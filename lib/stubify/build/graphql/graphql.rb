require "pry"

module Stubify
  module Build
    class GraphQL
      attr_accessor :data

      def initialize
        data_file = File.join(Stubify.data_dir, "")
        @data = Stubify.parse_json(data_file)
      end
      # data = parse_json('/Users/clay/TCD/shopify/shopify_util/data/graphql/out/admin_2019_10.json')

      # types = data[:data][:__schema][:types].collect { |n| n[:name] }
      nodes_list = data[:data][:__schema][:types][5][:possible_types].collect { |n| n[:name] }
      rest_resources = data[:data][:__schema][:types][11][:possible_types].collect { |n| n[:name] }

      # Product - 56
      # ProductVariant - 73
      # Customer - 171
      # Order - 181
      # MailingAddress -186

      def types
        data = parse_json("/Users/clay/TCD/shopify/shopify_util/data/graphql/out/admin_2019_10.json")
        res = []
        types = data[:data][:__schema][:types]
        types.each_with_index do |t_o, i|
          res << "#{i}: #{t_o[:name]}"
        end
        return res
      end

      def type_data(type_object)
        res = {}
        res[:name] = type_object[:name]
        res[:description] = type_object[:description]
        res[:fields] = []
        return res
      end

      def parse_basic(node)

      end

      def parse_field(field)
        res = {}
        res[:name] = field[:name]
        res[:description] = field[:description]
        t = field[:type]
        if t[:Kind] == "NON_NULL"
          res[:required] = true
          res[:type] = t[:ofType][:name]
        else
          res[:required] = false
          res[:type] = t[:name]
        end
        return res
      end

      def parse_enum(enum)
        res = {}
        res[:name] = enum[:name]
        res[:description] = enum[:description]
        res[:values] = []
        enum[:enumValues].each do |ev|
          val = {}
          val[:name] = ev[:name]
          val[:description] = ev[:description]
          res[:values] << val
        end
        return res
      end
    end
  end
end
