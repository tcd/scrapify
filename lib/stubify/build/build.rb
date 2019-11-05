require "HTTParty"
require "nokogiri"

module Stubify
  module Build

    REST_API_ROOT_URL = "https://help.shopify.com/en/api/reference".freeze
    GRAPHQL_API_ROOT_URL = "https://help.shopify.com/en/api/graphql-admin-api/reference/object".freeze
    GRAPHQL_SCHEMA_JS = "https://cdn.shopify.com/shopifycloud/help/bundles/latest/admin_graphiql-ccdbb06edfc834789e6c3b77dc52080be568cbbe144f101c87f477dee33d49de.js".freeze

    class Scraper
      # @return [String]
      attr_reader :url
      # @return [String]
      attr_reader :name
      # @return [Nokogiri::XML::Node]
      attr_reader :doc
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
    end

    # @return [Array<String>]
    def self.routes()
      return [
        "https://help.shopify.com/en/api/reference/customers/customer",
        # "https://help.shopify.com/en/api/reference/orders/order",
        # "https://help.shopify.com/en/api/reference/products/product",
        # "https://help.shopify.com/en/api/reference/products/product-variant",
      ]
    end

    # Generate YARD documentation from Shopify's API documentation
    def self.build()
      self.routes().each do |route|
        PropScraper.new(route).write_to_file()
      end
    end

  end
end
