require "pry"

module Falsify
  module Build
    module GraphQL

      # @param args [Hash<Symbol>]
      # @return [String]
      def self.generate_args(args)
        return nil if args.nil?
        return nil unless args.length.positive?
        a = []
        args.each do |arg|
          default = arg[:default] ? " = #{arg[:default]}" : ""
          bang = arg[:required] ? "!" : ""
          a << %("#{arg[:description]}"\n#{arg[:name]}: #{arg[:type]}#{default}#{bang})
        end
        return "(\n#{a.join("\n")}\n)"
      end

      # Not sure that this works, use {generate_args}
      # @return [String]
      def generate_single_arg(arg)
        default = arg[:default] ? " = #{arg[:default]}" : ""
        bang = arg[:required] ? "!" : ""
        return %(
(
  "#{arg[:description]}"
  #{arg[:name]}: #{arg[:type]}#{default}#{bang}
))
      end

      # Not sure that this works, use {generate_args}
      # @return [String]
      def generate_multi_arg(args)
        a = []
        args.each do |arg|
          default = arg[:default] ? " = #{arg[:default]}" : ""
          bang = arg[:required] ? "!" : ""
          a << %("#{arg[:description]}"\n#{arg[:name]}: #{arg[:type]}#{default}#{bang})
        end
        return "(\n#{a.join("\n")}\n)"
      end

      # @param union_data [Hash]
      # @return [String]
      def self.generate_union(u_data)
        return <<~END
          """#{u_data[:description]}"""
          union #{u_data[:name]} = #{u_data[:types].join(' | ')}
        END
      end

      # @param field [Hash]
      # @return [String]
      def self.generate_field(f)
        bang = f[:required] ? "!" : ""
        return "#{f[:name]}#{self.generate_args(f[:args])}: #{f[:type]}#{bang}"
      end

      def self.generate_interface(iface)
        fields = iface[:fields].map { |f| self.generate_field(f) }.join("\n  ")
        return %(
"#{iface[:description]}"
interface #{iface[:name]} {
  #{fields}
}

)
      end

      def self.save_interfaces(is)
        File.open("interface.gql", "a") do |f|
          is.each { |i| f.write(Falsify::Build::GraphQL.generate_interface(i)) }
        end
      end

    end
  end
end
