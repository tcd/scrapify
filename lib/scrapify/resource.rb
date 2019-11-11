module Scrapify
  class Resource
    attr_accessor :name
    attr_accessor :description
    attr_accessor :source
    attr_accessor :fields

    def self.create_from_document

    end
  end

  class Field
    attr_accessor :type
    attr_accessor :read_only
    attr_accessor :required
    attr_accessor :deprecated
    attr_accessor :example
    attr_accessor :note

    # @return [String]
    attr_accessor :name
    # @return [Boolean]
    attr_accessor :read_only
    # @return [Boolean]
    attr_accessor :required
    # @return [Boolean]
    attr_accessor :deprecated
    # @return [String]
    attr_accessor :example
    attr_accessor :base_description
    attr_accessor :full_description
    # @return [String]
    attr_accessor :note

  end
end
