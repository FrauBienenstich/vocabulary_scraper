#!/usr/bin/env ruby

require_relative 'preparator.rb'
require_relative 'writer.rb'
require_relative 'translator.rb'
require 'open-uri'
require 'nokogiri'
require 'json'


preparator = Preparator.new('https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/Finnish_wordlist', 'vocab.txt')

words = preparator.scrape_source
dictionary = preparator.start_list_to_h(words)
writer = Writer.new
writer.write_to_file(dictionary, 'vocab.txt')
translator = Translator.new('vocab.txt')
dictionary = translator.translate
writer.write_to_file(dictionary, 'vocab.txt')