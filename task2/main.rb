# frozen_string_literal: true

require 'rubygems'
require 'csv'
require 'nokogiri'
require 'curl'
require 'open-uri'

require_relative 'parse'
require_relative 'work_with_yaml'

Parse.parse(WorkWithYaml::GetParametr.getting_url, WorkWithYaml::GetParametr.getting_file_name)
