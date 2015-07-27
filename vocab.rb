#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'json'

url = 'https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/Finnish_wordlist'


def scrape_source(url)
  html = open(url)
  doc = Nokogiri::HTML(html)
  words = []
  doc.css("#mw-content-text li span").each do |word|
    words << word.text
  end
  words
end

def scrape_translation(filename)
  my_file = JSON.parse(File.read(filename))
  all_words = []
  my_file.each do |k, v|
    if v == ""
      adr = URI.escape('http://defi.dict.cc/?s=' + k)
      html = open(adr)

      doc = Nokogiri::HTML(html)
      doc.css('#maincontent .td7nl').each {|tag| all_words << tag.content }
    end
  end
  Hash[*all_words]
end

def write_to_file(hash, filename)
  json = hash.to_json
  File.open(filename, "w") { |f| f.write(json)}
end

def start_list_to_h(array_of_words)
  hashed_words = Hash.new

  array_of_words.each do |word|
    hashed_words[word] = ""
  end
  hashed_words
end

words = scrape_source(url)

dictionary = start_list_to_h(words)
#puts "DICT 1 #{dictionary}"

write_to_file(dictionary, 'vocab.txt')

dictionary = scrape_translation('vocab.txt')
#puts "DICT 2 #{dictionary}"

write_to_file(dictionary, 'vocab.txt')

#TODO rescue errors?




