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

def scrape_translation(file)
  my_file = JSON.parse(File.read(file))
  all_words = []
  my_file.each do |k, v|
    adr = URI.escape('http://defi.dict.cc/?s=' + k)
    html = open(adr)

    doc = Nokogiri::HTML(html)
    doc.css('#maincontent .td7nl').each {|tag| all_words << tag.content }
  end
  Hash[*all_words]
end

def write_to_file(hash, file)
  finnish_vocab = File.new(file, "w+")

  json = hash.to_json

  File.open(file, "a+") { |f| f.write(json)}
  finnish_vocab.close
end

def start_list_to_h(array_of_words)
  hashed_words = Hash.new

  array_of_words.each do |word|
    hashed_words[word] = ""
  end
  hashed_words
end


words = scrape_source(url)

hashed_start_list = start_list_to_h(words[0..20])

write_to_file(hashed_start_list, 'vocab.txt')

dictionary = scrape_translation('vocab.txt')

write_to_file(dictionary, 'vocab.txt')



