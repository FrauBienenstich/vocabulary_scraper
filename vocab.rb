#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

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

def scrape_translation(word_list)
  finnish_german = []
  word_list.each do |word|
    adr = URI.escape('http://defi.dict.cc/?s=' + word)
    html = open(adr)

    doc = Nokogiri::HTML(html)
    doc.css('#maincontent .td7nl').each {|tag| finnish_german << tag.content }

  end
  Hash[*finnish_german.flatten(1)]
end

def write_to_file(hash)
  finnish_vocab = File.new("vocab.html", "w+")

  hash.each do |k, v|
    File.open("vocab.html", "a+") { |file| file.write("<meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><p>#{k} = #{v}</p>") }
  end
  finnish_vocab.close
end

words = scrape_source(url)

dictionary = scrape_translation(words)

write_to_file(dictionary)



