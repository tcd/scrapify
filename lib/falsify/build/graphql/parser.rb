require "pry"

module Falsify
  module Build
    module GraphQL
      # TODO: Handle `LIST -> NON_NULL` kinds.
      class Parser
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

        # @return [Array<Hash>]
        def parse()
          res = []
          @data.each do |d|
            dat = parse_type(d)
            res << dat if dat
          end
          return res
        end

        # @return [Hash]
        def parse_type(type)
          case type[:kind]
          when "SCALAR"
            return nil
          # when "UNION"
          #   return parse_union(type)
          when "INTERFACE"
            return parse_interface(type)
          # when "ENUM"
          #   return parse_enum(type)
          # when "OBJECT"
          #   return parse_object(type)
          else
            return nil
          end
        end

        # @return [Hash]
        def parse_object(obj)
          data = {}
          data[:name]        = obj[:name]
          data[:description] = obj[:description]
          data[:fields]      = obj[:fields].map { |f| parse_field(f) }
          return data
        end

        # @param field [Hash]
        # @return [Hash]
        def parse_field(field)
          data = {}
          data[:name]        = field[:name]
          data[:description] = field[:description]
          if field[:args] && field[:args].length.positive?
            data[:args] = field[:args].map { |arg| parse_arg(arg) }
          else
            data[:args] = nil
          end
          type = field[:type]
          if type[:kind] == "NON_NULL"
            data[:required] = true
            if type[:ofType][:kind] == "LIST"
              data[:list] = true
              data[:type] = type[:ofType][:ofType][:ofType][:name]
            else
              data[:list] = false
              data[:type] = type[:ofType][:name]
            end
          else
            data[:list]     = false
            data[:required] = false
            data[:type]     = type[:name]
          end
          return data
        end

        # @return [Hash]
        def parse_arg(arg)
          data = {}
          data[:name]        = arg[:name]
          data[:description] = arg[:description]
          data[:default]     = arg[:defaultValue]
          type = arg[:type]
          if type[:kind] == "NON_NULL"
            data[:required] = true
            data[:type]     = type[:ofType][:name]
          else
            data[:required] = false
            data[:type]     = type[:name]
          end
          return data
        end

        # @return [Hash]
        def parse_enum(enum)
          data = {}
          data[:name]        = enum[:name]
          data[:description] = enum[:description]
          data[:values]      = []
          enum[:enumValues].each do |ev|
            val = {}
            val[:name]        = ev[:name]
            val[:description] = ev[:description]
            data[:values] << val
          end
          return res
        end

        # @return [Hash]
        def parse_union(union)
          data = {}
          data[:name]        = union[:name]
          data[:description] = union[:description]
          data[:types]       = union[:possibleTypes].map { |pt| pt[:name] }
          return data
        end

        # @return [Hash]
        def parse_interface(iface)
          data = {}
          data[:name]        = iface[:name]
          data[:description] = iface[:description]
          data[:fields]      = iface[:fields].map { |f| parse_field(f) }
          return data
        end

      end
    end
  end
end
