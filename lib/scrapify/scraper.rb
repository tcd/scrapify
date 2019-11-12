require "HTTParty"
require "nokogiri"

module Scrapify
  # Wrapper around a Nokogiri HTML::Document/XML::Node
  class Scraper
    # @return [String]
    attr_reader :source
    # @return [String]
    attr_reader :name
    # @return [Nokogiri::XML::Node]
    attr_reader :doc

    # @param url [String]
    # @return [void]
    def initialize(source:, name:, doc:)
      @source = source
      @name = name
      @doc = doc
    end

    # Can be used to scrape content from a webpage.
    # @param url [String]
    # @return [void]
    def self.web_scraper(url)
      return Scraper.new(
        source: url,
        name: File.basename(url),
        doc: Nokogiri::HTML(HTTParty.get(url)),
      )
    end

    # Can be used to scrape content from a local html file.
    # @param path [String]
    # @return [Scraper]
    def self.file_scraper(path)
      return Scraper.new(
        source: path,
        name: File.basename(path),
        doc: Nokogiri::HTML(File.read(path)),
      )
    end
  end
end
