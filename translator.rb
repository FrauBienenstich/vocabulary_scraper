class Translator
  attr_reader :filename
  def initialize(filename)
    @filename = filename
  end

  def translate
    my_file = JSON.parse(File.read(self.filename))
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

end