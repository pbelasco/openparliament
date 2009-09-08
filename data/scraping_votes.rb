# -*- coding: utf-8 -*-
require 'hpricot'
require 'yaml'
require 'ostruct'

# fix for screwed up net/http
# found at: http://pw.tech-arts.co.jp/technical/cat57/
module Net   #:nodoc:
  class HTTPResponse
    class << HTTPResponse
      def each_response_header(sock)
        pm = ['', '']
        while true
          line = sock.readuntil("\n", true).sub(/\s+\z/, '')
          break if line.empty?
          m = /\A([^:]+):\s*/.match(line)
          if m.nil?
            pm[1] += line
            next
          end
          yield pm[0], pm[1]
          pm = [m[1], m.post_match]
        end
      end
    end
  end   # HTTPResponse
end   # module Net


# from http://railsruby.blogspot.com/2006/07/url-escape-and-url-unescape.html
def url_escape(string)
  string.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
    '%' + $1.unpack('H2' * $1.size).join('%').upcase
  end.tr(' ', '+')
end


legislators = File.open("legislators.yml") { |f| YAML::load(f) }

field_names = ["legislator_id", "plenary_session", "date", "proposition_type",
               "proposition_number", "proposition_year", "title",
               "legislator_present", "vote"]
File.open("votes.csv", "w") { |f| f << field_names.map { |field| "\"#{field}\""}.join(",") + "\n" }

# legislators_to_rip = legislators.select { |d| d.votes.nil? }
legislators_to_rip = legislators
legislators_to_rip.each_with_index do |legislator, i|
  # we're trying to build this url:
  # http://www.camara.gov.br/internet/deputado/deputado_atual_resp.asp?fMode=1&deputado=ABELARDO%20CAMARINHA%7C528580%2523329%21SP%3DPSB&Pesquisa=Pesquisar&rbDeputado=VP&DepID=528580&DepUF=SP&DepMat=23329&DepPart=PSB
  legislator.site_metadata_votes_url = "http://www.camara.gov.br/internet/" \
  "deputado/deputado_atual_resp.asp?fMode=1&" \
  "deputado=#{url_escape(legislator.site_metadata_select_value)}&" \
  "Pesquisa=Pesquisar&rbDeputado=VP&DepID=#{legislator.legislator_id}&" \
  "DepUF=#{legislator.state_code}&" \
  "DepMat=#{legislator.subscription_number}&DepPart=#{legislator.party_code}"


  # exponential backoff for rate limiting
  wait_exponent = 1.0
  begin
    puts "(%d/%d) Scraping votes for #{legislator.name}" % [i+1, legislators_to_rip.size]
    puts legislator.site_metadata_votes_url
    doc = Hpricot(`links -source "#{legislator.site_metadata_votes_url}" | iconv -f ISO_8859-1 -t UTF-8`)
    rows = (doc / "tr")[1..-1]

    if rows.nil? || rows.empty?
      sleep_time = 2 ** wait_exponent
      puts "\nDIDN'T WORK. Let's wait #{sleep_time.to_i} seconds. " \
           "Here's the doc:\n"
      puts doc
      puts "==============================\n\n"
      sleep sleep_time
      wait_exponent += 0.5
    end
  end while rows.nil? || rows.empty?


  legislator.votes = []

  rows.each  do |row|
    begin
      unless row.nil?
        fields = (row / "td").map { |f| f.innerText.strip}
        if fields.size == 5
          plenary_session = fields[0]
          date = fields[1]

          if fields[2] =~ /Nº \d+\/\d+/
            proposition_type = fields[2].split(' ').first
            proposition_number = fields[2].split(/\s+/)[2].split('/').first
            proposition_year = fields[2].split(/\s+/)[2].split('/')[1]
            title = fields[2].split(' - ')[1..-1].join(' - ')
          else
            proposition_type, proposition_number, proposition_year = [''] * 3
            title = fields[2]
          end

          # Remove a question mark at the end of "Present"
          legislator_present = fields[3][0...-1]

          # extract type/number/year from title
          vote = fields[4]

          line = [legislator.legislator_id.to_s, plenary_session, date,
                  proposition_type, proposition_number, proposition_year,
                  title, legislator_present, vote].map {|field|
            "\"#{field}\""
          }

          File.open("votes.csv", "a") {|f| f << line.join(",") + "\n" }
          print '.' # progress indicator
        end
      end
    rescue Exception => e
      puts "EXCEPTION while scraping votins for #{legislator.name}: "
      puts e.inspect
      exit
    end
  end
  puts "\n"
end
