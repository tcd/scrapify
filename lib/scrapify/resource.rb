require "reverse_markdown"

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

    # @param name [String] Name of a local html file.
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

    # @param url [String]
    # @return [Scrapify::Resource]
    def self.from_remote(url)
      resource = Resource.new()
      s = Scrapify::Scraper.web_scraper(url)
      resource.name = s.name
      resource.description = "See the [API documentation](#{url})."
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

    # @return [Scrapify::Field]
    def field(name)
      return self.fields.find { |field| field.name == name }
    end

    # @return [String]
    def generate_description()
      if self.required_fields().length > 0
        req = "Required Fields:\n- " + self.required_fields().join("\n- ").indent(2)
      else
        req = ""
      end
      return req.comment
    end

    # @return [String]
    def generate()
      path = File.join(Scrapify.tmp_dir, name) + ".rb"
      fields = self.fields.map(&:generate).join("\n")
      output = <<~END
        module Falsify
          #{self.generate_description}
          class #{@name.capitalize}
          #{fields}
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
      description = @full_description.gsub(/\\_/, "_").split(". ").join(".\n").indent(2)
      result = <<~END
        @!attribute #{@name} [#{access}]
        #{description}
          @return [String]
      END
      # part_1 = "@!attribute #{@name} [#{access}]"
      # part_2 = @full_description.indent(2)
      # part_3 = ""
      # part_4 = "@return []".indent(2)
      part_5 = "attr_accessor :#{@name}"
      # return [part_1, part_2, part_3, part_4].join("\n").comment() + part_5
      return (result.comment + part_5).indent(4)
    end

  end

end
