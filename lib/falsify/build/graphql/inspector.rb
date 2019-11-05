require "pry"

module Falsify
  module Build
    module GraphQL
      class Inspector
        # Shopify GraphQL [Types](https://graphql.org/learn/schema/#type-system).
        # @return [Hash<Symbol>]
        attr_accessor :data

        # @return [void]
        def initialize()
          data_file = File.join(Falsify.data_dir, "2019-10/graphql/admin_2019_10.json")
          # Shopify GraphQL [Types](https://graphql.org/learn/schema/#type-system).
          # @type [Hash<Symbol>]
          @data = Falsify.parse_json(data_file)[:data][:__schema][:types]
        end

        # def thin_data()
        #   blacklist = []
        #   return @data.filter { |d| blacklist.include?(d[:name]) }
        # end

        # Return the names of all nodes.
        # @return [Array<String>]
        def nodes_list()
          return @data[5][:possible_types].collect { |n| n[:name] }
        end

        # Return the names of all legacy rest resources.
        # @return [Array<String>]
        def rest_resources()
          return @data[11][:possible_types].collect { |n| n[:name] }
        end

        # - Product - 56
        # - ProductVariant - 73
        # - Customer - 171
        # - Order - 181
        # - MailingAddress - 186
        # - LineItem - 209
        #
        # @return [Array<String>]
        def types()
          types = []
          @data.each_with_index do |t_o, i|
            types << "#{i}\t#{t_o[:name]}\t#{t_o[:kind]}"
          end
          return types
        end

      end
    end
  end
end
