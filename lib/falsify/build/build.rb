require "HTTParty"
require "nokogiri"

module Falsification
  module Build

    REST_API_ROOT_URL = "https://help.shopify.com/en/api/reference".freeze
    GRAPHQL_API_ROOT_URL = "https://help.shopify.com/en/api/graphql-admin-api/reference/object".freeze
    GRAPHQL_SCHEMA_JS = "https://cdn.shopify.com/shopifycloud/help/bundles/latest/admin_graphiql-ccdbb06edfc834789e6c3b77dc52080be568cbbe144f101c87f477dee33d49de.js".freeze

    # @return [Array<String>]
    def self.routes()
      return [
        # "https://help.shopify.com/en/api/reference/customers/customer",
        # "https://help.shopify.com/en/api/reference/orders/order",
        "https://help.shopify.com/en/api/reference/products/product",
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
