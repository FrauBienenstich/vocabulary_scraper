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
        begin
          adr = URI.escape('http://defi.dict.cc/?s=' + k)
          html = open(adr)#hier error catchen? und zwischenresult speichern

          doc = Nokogiri::HTML(html)
          doc.css('#maincontent .td7nl').each {|tag| all_words << tag.content }
        rescue OpenURI::HTTPError => ex
          response = ex.io
          response.status
          response.string
          next
        ensure
          all_words
        end
      end 
      Hash[*all_words]
    end
  end
end