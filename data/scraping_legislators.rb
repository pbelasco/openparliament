#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'
require 'ostruct'
require 'hpricot'
require 'yaml'


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


agent = WWW::Mechanize.new

legislators = []

# we're keeping a file just with the list of legislators so we don't need
# to read it again every time we're testing the extraction of their
# voting history (which is still buggy)
if File.exists?('legislators.yml')
  legislators = File.open('legislators.yml') { |f| YAML::load(f) }
else

  field_names = ['legislator_id', 'subscription_number', 'state_code',
                 'party_code', 'site_metadata_select_value']

  File.open('legislators.csv', 'w') { |f|
    f << field_names.map { |field| "\"#{field}\""}.join(',') + "\n"
  }


  page = agent.get('http://www2.camara.gov.br/deputados')
  form = page.form('form1')
  select = form.fields[5]

  legislators = []

  # the first option is just the label
  select.options[1..-1].each do |option|

    legislator = OpenStruct.new
    legislator.name = option.instance_eval('@text')

    option.instance_eval('@value') =~ /\|(\d+)%/
    legislator.legislator_id = $1

    option.instance_eval('@value') =~ /%(\d+)!/
    legislator.subscription_number = $1 # matricula

    option.instance_eval('@value') =~ /\!(.*)=/
    legislator.state_code = $1

    option.instance_eval('@value') =~ /=(.*)/
      legislator.party_code = $1

    # store the raw info we got from the select dropdown
    legislator.site_metadata_select_value = option.instance_eval('@value')

    puts legislator.name
    legislators << legislator
  end

  YAML::dump(legislators, File.open('legislators.yml', 'w'))

  legislators.each do |leg|
    fields = [leg.legislator_id.to_s, leg.name, leg.subscription_number,
              leg.state_code, leg.party_code, leg.site_metadata_select_value]
    line = fields.map { |field| "\"#{field}\""}.join(',') + "\n"
    File.open("legislators.csv", "a") {|f| f << line }
  end
end

