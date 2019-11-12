# Dir.glob(File.join(__dir__, "scrapify", "/**/*.rb")).sort.each { |file| require file }
require "HTTParty"

require "scrapify/helpers"
require "scrapify/resource"
require "scrapify/scraper"

# Stubs fo Shopify.
module Scrapify
  VERSION = "0.1.0".freeze

  REST_API_ROOT_URL = "https://help.shopify.com/en/api/reference".freeze
  GRAPHQL_API_ROOT_URL = "https://help.shopify.com/en/api/graphql-admin-api/reference/object".freeze
  GRAPHQL_SCHEMA_JS = "https://cdn.shopify.com/shopifycloud/help/bundles/latest/admin_graphiql-ccdbb06edfc834789e6c3b77dc52080be568cbbe144f101c87f477dee33d49de.js".freeze

  # @return [Array<String>]
  def self.routes()
    return [
      "https://help.shopify.com/en/api/reference/customers/customer",
      "https://help.shopify.com/en/api/reference/orders/order",
      "https://help.shopify.com/en/api/reference/products/product",
      "https://help.shopify.com/en/api/reference/products/product-variant",
      "https://help.shopify.com/en/api/reference/shipping-and-fulfillment/fulfillment",
    ]
  end

  # @return [void]
  def self.download_docs()
    self.routes().each do |route|
      name = File.basename(route)
      out_file = File.join(Scrapify.data_dir(), "html", (name + ".html"))
      doc = HTTParty.get(route)
      Scrapify.write_to_file(out_file, doc)
    end
  end

  # # Generate YARD documentation from Shopify's API documentation
  # def self.build()
  #   self.routes().each do |route|
  #     PropScraper.new(route).write_to_file()
  #   end
  # end
end
