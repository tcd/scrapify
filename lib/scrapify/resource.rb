require "reverse_markdown"
# require "active_support/core_ext/string"

module Scrapify

  class Resource
    attr_accessor :name
    attr_accessor :description
    attr_accessor :source
    attr_accessor :fields

    # @return [void]
    def initialize
      self.fields = []
    end

    # @param name [String]
    # @return [Scrapify::Resource]
    def self.from_local(name)
      resource = Resource.new()
      resource.name = name
      file = File.join(Scrapify.data_dir, "html", (name + ".html"))
      s = Scrapify::Scraper.file_scraper(file)
      props = s.doc.css(".doc-version--lastest .api-properties tbody tr")
      props.each do |prop|
        resource.fields.append(Field.from_prop(prop))
      end
      return resource
    end

    # @return [Array<String>]
    def required_fields
      self.fields.map { |f| f.name if f.required }.compact
    end

    # @return [String]
    def generate
      path = File.join(Scrapify.tmp_dir, name) + ".rb"
      output = <<~END
        module Falsify
          class #{@name.capitalize}

          end
        end
      END
      File.open(path, "a") do |f|
        f.write(output)
      end
    end

  end

  # Attribute data for a Resource.
  class Field
    # @return [String]
    attr_accessor :name
    # @return [String]
    attr_accessor :type
    # @return [Boolean]
    attr_accessor :read_only
    # @return [Boolean]
    attr_accessor :required
    # @return [Boolean]
    attr_accessor :deprecated
    # @return [String]
    attr_accessor :example
    # @return [String]
    attr_accessor :base_description
    # @return [String<Markdown>]
    attr_accessor :full_description
    # @return [String]
    attr_accessor :note

    def initialize
      self.name = ""
      self.type = ""
      self.read_only = false
      self.required = false
      self.deprecated = false
      self.example = ""
      self.base_description = ""
      self.full_description = ""
      self.note = nil
    end

    # @param prop [Nokogiri::XML::NodeSet]
    # @return [Scrapify::Field]
    def self.from_prop(prop)
      field = Scrapify::Field.new
      t1 = prop.css("td")[0]
      t2 = prop.css("td")[1]

      if t1.css("span").empty?
        field.name = t1.text.strip
        field.read_only = false
      else
        field.name = t1.children.first.text.strip
        case t1.css("span").text.strip
        when "required"
          field.required = true
        when "read-only"
          field.read_only = true
        when "deprecated"
          field.deprecated = true
        end
      end

      field.example = t2.css(".api-properties-example").text.strip
      field.base_description = t2.css("p").text.strip
      full_description = t2.css("p,ul")
      field.full_description = ReverseMarkdown.convert(full_description.to_s).strip

      return field
    end

    # @return [String]
    def generate()
      access = "r"
      access << "w" unless @read_only
      return <<~END
        # @!attribute #{@name} [#{access}]
        #   #{@full_description.gsub(/\n/, "\n  #   ")}
        #
        #   @return []
        attr_accessor :#{name}
      END
    end

  end

end
