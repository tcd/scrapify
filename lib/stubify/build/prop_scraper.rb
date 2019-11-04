require "HTTParty"
require "nokogiri"
require "reverse_markdown"

module Stubify
  module Build

    class PropData
      # @return [Nokogiri::XML::NodeSet]
      attr_reader :t1
      # @return [Nokogiri::XML::NodeSet]
      attr_reader :t2

      # @return [String]
      attr_accessor :name
      # @return [Boolean]
      attr_accessor :read_only
      # @return [Boolean]
      attr_accessor :required
      # @return [String]
      attr_accessor :example
      attr_accessor :base_description
      attr_accessor :full_description
      # @return [String]
      attr_accessor :note

      def initialize(prop)
        @t1 = prop.css("td")[0]
        @t2 = prop.css("td")[1]
        self.process_t1()
        self.process_t2()
      end

      # @return [void]
      def process_t1
        if @t1.css("span").empty?
          @name = @t1.text.strip
          @read_only = false
        else
          @name = @t1.children.first.text.strip
          @read_only = true
        end
      end

      # @return [void]
      def process_t2
        @example = @t2.css(".api-properties-example").text.strip
        @base_description = @t2.css("p").text.strip
        full_description = @t2.css("p,ul")
        @full_description = ReverseMarkdown.convert(full_description.to_s).strip
      end

      # @return [String]
      def doc
        doc = "# @!attribute #{@name} "
        if @read_only
          doc << "[r]"
        else
          doc << "[rw]"
        end
        doc << "\n"
        doc << "#   #{@full_description.gsub(/\n/, "\n#   ")}\n"
        doc << "\n"
        return doc
      end

      # @return [String]
      def doc2
        access = "r"
        access << "w" unless @read_only
        return %(
    # @!attribute #{self.name} [#{access}]
    #   #{self.full_description.gsub(/\n/, "\n  #   ")}
    #
    #   @return [String])
      end

    end

    # Used for scraping Shopify's online API documentation.
    class PropScraper
      # @return [String]
      attr_reader :url
      # @return [String]
      attr_reader :name
      # @return [Nokogiri::XML::Node]
      attr_reader :doc

      def initialize(url)
        @url = url
        @name = File.basename(url)
        # @type [Nokogiri::HTML::Document]
        @doc ||= Nokogiri::HTML(HTTParty.get(url))
      end

      # @return [Nokogiri::XML::NodeSet]
      def props
        props = @doc.css(".doc-version--lastest .api-properties tbody tr")
        return props
      end

      # @return [Array<String>]
      def process_props
        docs = []
        @props.each do |prop|
          docs.append(PropData.new(prop).doc2)
        end
        return docs
      end

      # @return [void]
      def write_to_file
        path = File.join(Stubify.data_dir, name) + ".rb"
        props = self.process_props
        File.open(path, "a") do |f|
          f.write("\nclass #{@name.capitalize}\n")
          props.each do |prop|
            f.write(prop)
          end
          f.write("\nend")
        end
      end
    end

    # Used for scraping Shopify's online API documentation.
    class ModelMaker
      # @return [String]
      attr_reader :url
      # @return [String]
      attr_reader :name
      # @return [Nokogiri::XML::Node]
      attr_reader :doc

      def initialize(url)
        @url = url
        @name = File.basename(url)
        # @type [Nokogiri::HTML::Document]
        @doc ||= Nokogiri::HTML(HTTParty.get(url))
      end

      # @return [Nokogiri::XML::NodeSet]
      def props
        props = @doc.css(".doc-version--lastest .api-properties tbody tr")
        return props
      end

      # @return [Array<String>]
      def process_props
        docs = []
        self.props.each do |prop|
          docs.append(PropData.new(prop).doc)
        end
        return docs
      end

      # @return [void]
      def write_to_file
        path = File.join(Stubify.data_dir, name) + ".txt"
        props = self.process_props
        File.open(path, "a") do |f|
          props.each do |prop|
            f.write(prop)
          end
        end
      end
    end

  end
end
