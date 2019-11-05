require "test_helper"

class GraphQLTest < Minitest::Test

  def test_parse_field1
    want = {
      name: "handle",
      description: "Handle of the app.",
      required: false,
      list: false,
      args: nil,
      type: "String",
    }
    data = Stubify.parse_json(file_fixture("field1.json"))
    p = Stubify::Build::GraphQL::Parser.new()
    have = p.parse_field(data)
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
    data = Stubify.parse_json(file_fixture("field2.json"))
    p = Stubify::Build::GraphQL::Parser.new()
    have = p.parse_field(data)
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
    data = Stubify.parse_json(file_fixture("field3.json"))
    p = Stubify::Build::GraphQL::Parser.new()
    have = p.parse_field(data)
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
    data = Stubify.parse_json(file_fixture("field4.json"))
    p = Stubify::Build::GraphQL::Parser.new()
    have = p.parse_field(data)
    assert_equal(want, have)
  end

end
