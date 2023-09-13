class DataPreserver
  def initialize(file_name)
    @file_name = file_name
  end
end

class FileWriter < DataPreserver
  def write(data)
    json_data = JSON.pretty_generate(data)
    File.write(@file_name, json_data)
  end
end

class FileReader < DataPreserver
  def read
    FileWriter.new(@file_name).write([]) unless File.exist?(@file_name)
    file = File.read(@file_name)
    JSON.parse(file)
  end
end
