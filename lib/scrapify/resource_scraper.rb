module Scrapify
  # Used for scraping Shopify's online API documentation.
  class ResourceScraper < Scraper
    # @return [Nokogiri::XML::NodeSet]
    def props()
      props = @doc.css(".doc-version--lastest .api-properties tbody tr")
      return props
    end

    # @return [Array<String>]
    def process_props()
      docs = []
      self.props().each do |prop|
        docs.append(PropData.new(prop).doc2())
      end
      return docs
    end

    # @return [void]
    def write_to_file()
      path = File.join(Scrapify.tmp_dir, name) + ".rb"
      props = self.process_props()
      File.open(path, "a") do |f|
        f.write("\nclass #{@name.capitalize}\n")
        props.each do |prop|
          f.write(prop, "\n")
        end
        f.write("\nend")
      end
    end

  end
end
