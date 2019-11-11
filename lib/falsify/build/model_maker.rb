require "reverse_markdown"

module Falsification
  module Build

    # Used for scraping Shopify's online API documentation.
    class ModelMaker < Scraper
      # @return [Nokogiri::XML::NodeSet]
      def props()
        props = @doc.css(".doc-version--lastest .api-properties tbody tr")
        return props
      end

      # @return [Array<String>]
      def process_props()
        docs = []
        self.props().each do |prop|
          docs.append(PropData.new(prop).doc())
        end
        return docs
      end

      # @return [void]
      def write_to_file()
        path = File.join(Falsification.data_dir(), name) + ".txt"
        props = self.process_props()
        File.open(path, "a") do |f|
          props.each do |prop|
            f.write(prop)
          end
        end
      end
    end

  end
end
