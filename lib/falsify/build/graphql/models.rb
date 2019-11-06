module Falsify
  module Build
    module GraphQL

      # Basic definition of `==` for comparing two class instances.
      module BasicComparison
        # Compare two class instances.
        def ==(other)
          other.class == self.class && other.state == self.state
        end
        alias eql? ==

        # The state of a class instance, used for comparison by {==}
        def state
          self.instance_variables.map { |variable| self.instance_variable_get variable }
        end
      end

      # Information about a GraphQL [Field](https://graphql.org/learn/schema/#object-types-and-fields).
      class Field
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] type
        #   @return [String]
        attr_accessor :type

        # @!attribute [rw] required
        #   True if the Field's `type` or type list is required
        #   See the [Non-Null modifier](https://graphql.org/learn/schema/#lists-and-non-null) in the GraphQL Spec.
        #   @return [Boolean]
        attr_accessor :required

        # @!attribute [rw] list
        #   Whether the Field's `type` is an array.
        #   See the [List modifier](https://graphql.org/learn/schema/#lists-and-non-null) in the GraphQL Spec.
        #   @return [Boolean]
        attr_accessor :list

        # @!attribute [rw] members_required
        #   True if the Field's `type` is an array and the members of that array are `Non-Null`.
        #   See the [Non-Null modifier](https://graphql.org/learn/schema/#lists-and-non-null) in the GraphQL Spec.
        #   @return [Boolean]
        attr_accessor :members_required

        # @!attribute [rw] args
        #   @return [Array<Argument>]
        attr_accessor :args

        # @param name [String]
        # @param description [String]
        # @param type [Array<String>]
        # @param required [Boolean]
        # @param list [Boolean]
        # @param members_required [Boolean]
        # @param args [Array<Argument>]
        # @return [void]
        def initialize(
          name: nil,
          description: nil,
          type: nil,
          required: false,
          list: false,
          members_required: false,
          args: []
        )
          self.name             = name
          self.description      = description
          self.type             = type
          self.required         = required
          self.list             = list
          self.members_required = members_required
          self.args             = args
        end

        # @param array [Array<Hash>>]
        # @return [Array<Field>]
        def self.from_array(array)
          return array.map { |f| self.new(**f) }
        end
      end

      # Information about a GraphQL [Argument](https://graphql.org/learn/schema/#arguments).
      class Argument
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] type
        #   @return [String]
        attr_accessor :type

        # @!attribute [rw] required
        #   [See the GraphQL Spec](https://graphql.org/learn/schema/#lists-and-non-null).
        #   @return [Boolean]
        attr_accessor :required

        # @!attribute [rw] default
        #   @return [String, nil]
        attr_accessor :default

        # @param name [String]
        # @param description [String]
        # @param type [String]
        # @param required [Boolean]
        # @param default [String, nil]
        # @return [void]
        def initialize(
          name: nil,
          description: nil,
          type: nil,
          required: false,
          default: nil
        )
          self.name        = name
          self.description = description
          self.type        = type
          self.required    = required
          self.default     = default
        end

        # @param array [Array<Hash>]
        # @return [Array<Argument>]
        def self.from_array(array)
          return array.map { |f| self.new(**f) }
        end
      end

      # Information about a GraphQL [Scalar type](https://graphql.org/learn/schema/#scalar-types).
      class Scalar
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @param name [String]
        # @param description [String]
        # @return [void]
        def initialize(name: nil, description: nil)
          self.name        = name
          self.description = description
        end
      end

      # Information about a GraphQL [Object type](https://graphql.org/learn/schema/#object-types-and-fields).
      class Object
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] fields
        #   @return [Array<Field>]
        attr_accessor :fields

        # @!attribute [rw] interfaces
        #   Interfaces implemented by the Object.
        #   @return [Array<String>]
        attr_accessor :interfaces

        # @return [void]
        def initialize(name: nil, description: nil, fields: [], interfaces: [])
          self.name        = name
          self.description = description
          self.fields      = fields
          self.interfaces  = interfaces
        end
      end

      # Information about a GraphQL [Union type](https://graphql.org/learn/schema/#union-types).
      class Union
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] types
        #   @return [Array<String>]
        attr_accessor :types

        # @param name [String]
        # @param description [String]
        # @param types [Array<String>]
        # @return [void]
        def initialize(name: nil, description: nil, types: [])
          self.name        = name
          self.description = description
          self.types       = types
        end
      end

      # Information about a GraphQL [Enumeration type](https://graphql.org/learn/schema/#enumeration-types).
      class Enum
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] values
        #   @return [Array<EnumValue>]
        attr_accessor :values

        # @param name [String]
        # @param description [String]
        # @param values [Array<EnumValue>]
        # @return [void]
        def initialize(name: nil, description: nil, values: [])
          self.name        = name
          self.description = description
          self.values      = values
        end
      end

      # Information about an individual value in a GraphQL [Enumeration type](https://graphql.org/learn/schema/#enumeration-types).
      class EnumValue
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @param name [String]
        # @param description [String]
        # @return [void]
        def initialize(name: nil, description: nil)
          self.name        = name
          self.description = description
        end
      end

      # Information about a GraphQL [Interface](https://graphql.org/learn/schema/#interfaces).
      class Interface
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] fields
        #   @return [Array<Field>]
        attr_accessor :fields

        # @param name [String]
        # @param description [String]
        # @param fields [Array<Field>]
        # @return [void]
        def initialize(name: nil, description: nil, fields: [])
          self.name        = name
          self.description = description
          self.fields      = fields
        end
      end

      # Information about a GraphQL [Input type](https://graphql.org/learn/schema/#input-types).
      class Input
        include BasicComparison

        # @!attribute [rw] name
        #   @return [String]
        attr_accessor :name

        # @!attribute [rw] description
        #   @return [String, nil]
        attr_accessor :description

        # @!attribute [rw] fields
        #   @return [Array<Field>]
        attr_accessor :fields

        # @param name [String]
        # @param description [String]
        # @param fields [Array<Field>]
        # @return [void]
        def initialize(name: nil, description: nil, fields: [])
          self.name        = name
          self.description = description
          self.fields      = fields
        end
      end

    end
  end
end
