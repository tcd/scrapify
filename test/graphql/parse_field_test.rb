require "test_helper"

class ParseFieldTest < Minitest::Test

  def test_parse_field1
    want = {
      name: "handle",
      description: "Handle of the app.",
      required: false,
      list: false,
      args: nil,
      type: "String",
    }
    data = Falsify.parse_json(file_fixture("introspection-json/field1.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_field(data)
    assert_equal(want, have)
  end

  def test_parse_field2
    want = {
      name: "apiKey",
      description: "A unique application API identifier.",
      required: true,
      list: false,
      args: nil,
      type: "String",
    }
    data = Falsify.parse_json(file_fixture("introspection-json/field2.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_field(data)
    assert_equal(want, have)
  end

  def test_parse_field3
    want = {
      name: "features",
      description: "List of app features.",
      required: true,
      list: true,
      args: nil,
      type: "String",
    }
    data = Falsify.parse_json(file_fixture("introspection-json/field3.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_field(data)
    assert_equal(want, have)
  end

  def test_parse_field4
    want = {
      name: "metafield",
      description: "The metafield associated with the resource.",
      required: false,
      list: false,
      type: "Metafield",
      args: [
        {
          name: "namespace",
          description: "Container for a set of metafields (maximum of 20 characters).",
          default: nil,
          required: true,
          type: "String",
        },
        {
          name: "key",
          description: "Identifier for the metafield (maximum of 30 characters).",
          default: nil,
          required: true,
          type: "String",
        },
      ],
    }
    data = Falsify.parse_json(file_fixture("introspection-json/field4.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_field(data)
    assert_equal(want, have)
  end

end
