#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'fileutils'
require 'open-uri'


# the url is case-insensitive
base_url = "http://www.camara.gov.br/internet/plenario/result/votacao/%s%0.2d.zip"

month_names = [
'Janeiro',
'Fevereiro',
'Março',
'Abril',
'Maio',
'Junho',
'Julho',
'Agosto',
'Setembro',
'Outubro',
'Novembro',
'Dezembro'
]

legislature = 53

start_year = 2007
end_year = 2010

(start_year..end_year).each do |year|
  month_names.each_with_index do |month, i|
    url = base_url % [month, year % 100]
    path = File.join(Dir.pwd, 'source_data', year.to_s,
                     "%0.2d" % (i + 1))
    filename = 'source.zip'
    filepath = File.join(path, filename)
    FileUtils.mkpath(path)
    `wget -O #{filepath} #{url}`
    `unzip -d #{path} #{filepath}`
  end
end
