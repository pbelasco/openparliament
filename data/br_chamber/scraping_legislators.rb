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

field_names = ['chamber_id', 'nickname', 'subscription_number', 'state_code',
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
  legislator.nickname = option.instance_eval('@text')

  option.instance_eval('@value') =~ /\|(\d+)%/
  legislator.chamber_id = $1

  option.instance_eval('@value') =~ /%(\d+)!/
  legislator.subscription_number = $1 # matricula

  option.instance_eval('@value') =~ /\!(.*)=/
  legislator.state_code = $1

  option.instance_eval('@value') =~ /=(.*)/
    legislator.party_code = $1

  # store the raw info we got from the select dropdown
  legislator.site_metadata_select_value = option.instance_eval('@value')

  puts legislator.nickname
  legislators << legislator
end

legislators.each do |leg|
  fields = field_names.map{|field| leg.send(field.to_sym).to_s }
  line = fields.map { |field| "\"#{field}\""}.join(',') + "\n"
  File.open("legislators.csv", "a") {|f| f << line }
end

