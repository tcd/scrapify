module Stubify

  # Return a hash with symbolized keys parsed from a given JSON file.
  #
  # @param file [String]
  # @return [String<JSON>]
  def self.parse_json(file)
    return JSON.parse(File.read(file), symbolize_names: true)
  end

  # Append data to the end of a file.
  # The file is created if it doesn't exist.
  #
  # @param file [String] Path to the file.
  # @param data [String,#to_s] Data to write to the file.
  # @return [void]
  def self.write_to_file(file, data)
    FileUtils.mkdir_p(File.dirname(file))
    File.open(file, "a") do |f|
      f.write(data)
    end
  end

  # Directory where the gem is located.
  # @return [String]
  def self.root_dir
    return File.expand_path("../../..", __FILE__)
  end

  # Directory for writing out files.
  # @return [String]
  def self.data_dir
    return File.join(self.root_dir, "data")
  end

end
