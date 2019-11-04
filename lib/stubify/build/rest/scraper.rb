require "HTTParty"
require "nokogiri"

module Stubify
  module Build
    class Scraper
      # @return [String]
      attr_reader :url
      # @return [String]
      attr_reader :name
      attr_reader :doc
      # @param url [String]
      # @return [void]
      def initialize(url)
        @url = url
        @name = File.basename(url)
        @doc ||= Nokogiri::HTML(HTTParty.get(url))
      end
    end
  end
end
