class Writer
  attr_reader :filename
  def initialize(filename)
    @filename = filename
  end

  def write_to_file(hash)
    json = hash.to_json
    File.open(self.filename, "w") { |f| f.write(json)}
  end

  def make_nice(filename)
    my_file = JSON.parse(File.read(filename))
    my_file.each do |k, v|
      puts "<!DOCTYPE html><html><head><meta charset='UTF-8'></head><body><p>#{k} = #{v}</p></body>"
    end
  end
end