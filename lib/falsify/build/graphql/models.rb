module Falsify
  module Build
    module GraphQL

      # Name Description pair
      class ND < Struct.new(:name, :description)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String]
      end

      # Enum Object
      class Enum < Struct.new(:name, :description, :values)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String]

        # @!attribute [rw] values
        #   @return [Array<Hash>]
      end

      class Argument < Struct.new(:name, :description, :default, :required, :type)
        # @!attribute [rw] name
        #   @return [String]

        # @!attribute [rw] description
        #   @return [String]

        # @!attribute [rw] default
        #   @return [String]

        # @!attribute [rw] required
        #   @return [Boolean]

        # @!attribute [rw] type
        #   @return [String]
      end

      class Field < Struct.new(:name, :description, :args, :required, :type, :list)

      end

    end
  end
end
