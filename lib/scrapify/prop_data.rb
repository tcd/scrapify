# require "reverse_markdown"

module Scrapify
  class PropData
    # @return [Nokogiri::XML::NodeSet]
    attr_reader :t1
    # @return [Nokogiri::XML::NodeSet]
    attr_reader :t2

    # @return [Scrapify::Build::Field]
    attr_accessor :field

    def initialize(prop)
      @t1 = prop.css("td")[0]
      @t2 = prop.css("td")[1]
      self.process_t1()
      self.process_t2()
    end

    # @return [void]
    def process_t1()
      if @t1.css("span").empty?
        @name = @t1.text.strip
        @read_only = false
      else
        @name = @t1.children.first.text.strip
        case    @t1.css("span").text.strip
        when "required"
          @required = true
        when "read-only"
          @read_only = true
        when "deprecated"
          @deprecated = true
        end
      end
    end

    # @return [void]
    def process_t2()
      @example = @t2.css(".api-properties-example").text.strip
      @base_description = @t2.css("p").text.strip
      full_description = @t2.css("p,ul")
      @full_description = ReverseMarkdown.convert(full_description.to_s).strip
    end

    # @return [String]
    def doc()
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
    def doc2()
      access = "r"
      access << "w" unless @read_only
      return <<~END
        # @!attribute #{@name} [#{access}]
        #   #{@full_description.gsub(/\n/, "\n  #   ")}
        #
        #   @return []
      END
    end
  end
end
