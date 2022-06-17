require "rubygems"
require "csv"
require "nokogiri"
require "curl"
require "open-uri"

require_relative "Parse"
require_relative "WorkWithYaml"

Parse.parse(WorkWithYaml::GetParametr.get_url, WorkWithYaml::GetParametr.get_file_name);