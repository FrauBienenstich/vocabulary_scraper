class Preparator

  attr_reader :source_url, :filename

  def initialize(source_url, filename)
    @source_url = source_url
    @filename = filename
  end 

  def scrape_source
    html = open(self.source_url)
    doc = Nokogiri::HTML(html)
    words = []
    doc.css("#mw-content-text li span").each do |word|
      words << word.text
    end
    words
  end

  def start_list_to_h(array_of_words)
    hashed_words = Hash.new

    array_of_words.each do |word|
      hashed_words[word] = ""
    end
    hashed_words
  end
end



