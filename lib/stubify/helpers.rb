module Stubify

  # Read a TSV file and return its contents as an array of hashes.
  #
  # @param filepath [String] Path to the TSV file.
  # @return [Array<Hash>]
  def self.data_from_tsv_file(filepath)
    return CSV.read(
      filepath,
      col_sep: "\t",
      headers: true,
      header_converters: :symbol,
    ).map(&:to_hash)
  end

  # Return a hash with symbolized keys parsed from a given JSON file.
  #
  # @param file [String]
  # @return [Hash<Symbol>]
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

  # Directory for writing out files.
  # @return [String]
  def self.tmp_dir
    return File.join(self.root_dir, "tmp")
  end

end
