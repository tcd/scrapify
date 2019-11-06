module Falsify
  module Build
    module GraphQL

      # Information about a GraphQL [Field](https://graphql.org/learn/schema/#object-types-and-fields).
      class Field < Struct.new(:name, :description, :type, :required, :list, :args)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]

        # @!attribute [rw] type
        #   @return [String]

        # @!attribute [rw] required
        #   [See the GraphQL Spec](https://graphql.org/learn/schema/#lists-and-non-null).
        #   @return [Boolean]

        # @!attribute [rw] list
        #   [See the GraphQL Spec](https://graphql.org/learn/schema/#lists-and-non-null).
        #   @return [Boolean]

        # @!attribute [rw] args
        #   @return [Array<Argument>, nil]
      end

      # Information about a GraphQL [Argument](https://graphql.org/learn/schema/#arguments).
      class Argument < Struct.new(:name, :description, :type, :default, :required)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]

        # @!attribute [rw] type
        #   @return [String]

        # @!attribute [rw] default
        #   @return [String, nil]

        # @!attribute [rw] required
        #   [See the GraphQL Spec](https://graphql.org/learn/schema/#lists-and-non-null).
        #   @return [Boolean]
      end

      # Information about a GraphQL [Scalar type](https://graphql.org/learn/schema/#scalar-types).
      class Scalar < Struct.new(:name, :description)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]
      end

      # Information about a GraphQL [Union type](https://graphql.org/learn/schema/#union-types).
      class Union < Struct.new(:name, :description, :types)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]

        # @!attribute [rw] types
        #   @return [Array<String>]
      end

      # Information about a GraphQL [Enumeration type](https://graphql.org/learn/schema/#enumeration-types).
      class Enum < Struct.new(:name, :description, :values)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]

        # @!attribute [rw] values
        #   @return [Array<Hash>]
      end

      # Information about a GraphQL [Interface](https://graphql.org/learn/schema/#interfaces).
      class Interface < Struct.new(:name, :description, :values)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]

        # @!attribute [rw] fields
        #   @return [Array<Field>]
      end

      # Information about a GraphQL [Object type](https://graphql.org/learn/schema/#object-types-and-fields).
      class Object < Struct.new(:name, :description, :fields, :implements)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]

        # @!attribute [rw] fields
        #   @return [Array<Field>]

        # @!attribute [rw] implements
        #   @return [Array<String>, nil]
      end

      # Information about a GraphQL [Input type](https://graphql.org/learn/schema/#input-types).
      class Input < Struct.new(:name, :description)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String, nil]
      end

    end
  end
end
