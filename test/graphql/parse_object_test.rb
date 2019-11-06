require "test_helper"

class ParseObjectTest < Minitest::Test

  def test_parse_object1
    want = Falsify::Build::GraphQL::Object.new(
      name: "PublishedTranslation",
      description: "Published translation of a field of a resource.",
      fields: Falsify::Build::GraphQL::Field.from_array([
        {
          name: "key",
          description: "Translation key.",
          type: "String",
          required: true,
        },
        {
          name: "locale",
          description: "Translation locale.",
          type: "String",
          required: true,
        },
        {
          name: "value",
          description: "Translation value.",
          type: "String",
        },
      ]),
    )
    data = Falsify.parse_json(file_fixture("introspection-json/object1.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_object(data)
    assert_equal(want, have)
  end

  def test_parse_object2
    want = Falsify::Build::GraphQL::Object.new(
      name: "SEO",
      description: "SEO information.",
      fields: Falsify::Build::GraphQL::Field.from_array([
        {
          name: "description",
          description: "SEO Description.",
          type: "String",
        },
        {
          name: "title",
          description: "SEO Title.",
          type: "String",
        },
      ]),
    )
    data = Falsify.parse_json(file_fixture("introspection-json/object2.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_object(data)
    assert_equal(want, have)
  end

  def test_parse_object3
    want = Falsify::Build::GraphQL::Object.new(
      name: "UserError",
      description: "Represents an error in the input of a mutation.",
      fields: Falsify::Build::GraphQL::Field.from_array([
        {
          name: "field",
          description: "Path to the input field which caused the error.",
          type: "String",
          list: true,
          members_required: true,
        },
        {
          name: "message",
          description: "The error message.",
          type: "String",
          required: true,
        },
      ]),
      interfaces: ["DisplayableError"],
    )
    data = Falsify.parse_json(file_fixture("introspection-json/object3.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_object(data)
    assert_equal(want, have)
  end

end
