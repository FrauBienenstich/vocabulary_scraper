class Writer
  attr_reader
  def initialize
  end

  def write_to_file(text, filename)
    converted = text.to_json.gsub!(/\A"|"\Z/, '')

    File.open(filename, "w") { |f| f.write(converted)}
  end

  def make_nice(filename)
    my_file = JSON.parse(File.read(filename))
    words = []
    my_file.each do |k, v|
      words << "<p>#{k} " + "= " + "#{v}</p>" 
    end
    words = words.join(', ').gsub(",","")
    "<!DOCTYPE html><html><head><meta charset='UTF-8'></head><body>#{words}</body>"
  end

end