# require "HTTParty"
# require "nokogiri"

module Scrapify
  class Scraper
    # @return [String]
    attr_reader :url
    # @return [String]
    attr_reader :name
    # @return [Nokogiri::XML::Node]
    attr_reader :doc

    # Can be used to scrape content from a webpage.
    # @param url [String]
    # @return [void]
    def initialize(url)
      @url = url
      # Basename of `@url`.
      @name = File.basename(url)
      # FIXME: remove `@type` comment.
      # @type [Nokogiri::HTML::Document]
      @doc ||= Nokogiri::HTML(HTTParty.get(url))
    end

    # Can be used to scrape content from a local html file.
    # @param path [String]
    # @return [Scraper]
    def self.file_scraper(path)

    end
  end
end
