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
            res.append(dat) if dat
          end
          return res
        end

        # @param type [Hash<Symbol>]
        # @return [Scalar,Object,Enum,Union,Interface,nil]
        def parse_type(type)
          case type[:kind]
          when "SCALAR"
            return nil
          when "OBJECT"
            return parse_object(type)
          # when "ENUM"
          #   return parse_enum(type)
          # when "UNION"
          #   return parse_union(type)
          # when "INTERFACE"
          #   return parse_interface(type)
          else
            return nil
          end
        end

        # @param data [Hash<Symbol>]
        # @return [Object]
        def parse_object(data)
          object = Object.new()
          object.name        = data[:name]
          object.description = data[:description]
          object.fields      = data[:fields].map { |f| parse_field(f) }
          if data[:interfaces].length.positive?
            object.interfaces = data[:interfaces].collect { |i| i[:name] }
          end
          return object
        end

        # @param data [Hash<Symbol>]
        # @return [Field]
        def parse_field(data)
          field = Field.new()
          field.name        = data[:name]
          field.description = data[:description]
          # if data&.[](:args)&.length&.positive?
          if data[:args] && data[:args].length.positive?
            field.args = data[:args].map { |arg| parse_argument(arg) }
          end

          if data[:type][:kind] == "LIST"
            field.list = true
            if data[:type][:ofType][:kind] == "NON_NULL"
              field.members_required = true
              field.type             = data[:type][:ofType][:ofType][:name]
            else
              field.type = data[:type][:ofType][:name]
            end
          elsif data[:type][:kind] == "NON_NULL"
            field.required = true
            if data[:type][:ofType][:kind] == "LIST"
              field.list = true
              if data[:type][:ofType][:ofType][:kind] == "NON_NULL"
                field.members_required = true
                field.type             = data[:type][:ofType][:ofType][:ofType][:name]
              else
                field.type = data[:type][:ofType][:ofType][:name]
              end
            else
              field.type = data[:type][:ofType][:name]
            end
          else
            field.type = data[:type][:name]
          end

          return field
        end

        # TODO: Handle List args?
        # @param data [Hash<Symbol>]
        # @return [Argument]
        def parse_argument(data)
          arg = Argument.new()
          arg.name        = data[:name]
          arg.description = data[:description]
          arg.default     = data[:defaultValue]
          if data[:type][:kind] == "NON_NULL"
            arg.required = true
            arg.type = data[:type][:ofType][:name]
          else
            arg.type = data[:type][:name]
          end
          return arg
        end

        # @param data [Hash<Symbol>]
        # @return [Enum]
        def parse_enum(data)
          enum = Enum.new()
          enum.name        = data[:name]
          enum.description = data[:description]
          data[:enumValues].each do |v|
            enum.values.append({
              name:        v[:name],
              description: v[:description],
            })
          end
          return enum
        end

        # @param data [Hash<Symbol>]
        # @return [Union]
        def parse_union(data)
          union = Union.new()
          union.name        = data[:name]
          union.description = data[:description]
          union.types       = data[:possibleTypes].map { |pt| pt[:name] }

          return union
        end

        # @param data [Hash<Symbol>]
        # @return [Interface]
        def parse_interface(data)
          iface = Interface.new()
          iface.name        = data[:name]
          iface.description = data[:description]
          iface.fields      = data[:fields].map { |f| parse_field(f) }
          return iface
        end

      end
    end
  end
end
