#!/usr/bin/env ruby

require_relative 'preparator.rb'
require_relative 'writer.rb'
require_relative 'translator.rb'
require 'open-uri'
require 'nokogiri'
require 'json'

writer = Writer.new
text = writer.make_nice('vocab.txt')
writer.write_to_file(text, "dictionary.html")