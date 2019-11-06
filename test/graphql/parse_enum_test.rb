require "test_helper"

class ParseEnumTest < Minitest::Test

  def test_parse_enum1
    want = Falsify::Build::GraphQL::Enum.new(
      name: "PriceRuleTarget",
      description: "The type of lines (line_item or shipping_line) to which the price rule applies.",
      values: [
        {
          name: "LINE_ITEM",
          description: "The price rule applies to line items.",
        },
        {
          name: "SHIPPING_LINE",
          description: "The price rule applies to shipping lines.",
        },
      ],
    )
    data = Falsify.parse_json(file_fixture("introspection-json/enum1.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_enum(data)
    assert_equal(want, have)
  end

  def test_parse_enum2
    want = Falsify::Build::GraphQL::Enum.new(
      name: "DisputeType",
      description: "The possible types for a dispute.",
      values: [
        {
          name: "CHARGEBACK",
          description: nil,
        },
        {
          name: "INQUIRY",
          description: nil,
        },
      ],
    )
    data = Falsify.parse_json(file_fixture("introspection-json/enum2.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_enum(data)
    assert_equal(want, have)
  end

  def test_parse_enum3
    want = Falsify::Build::GraphQL::Enum.new(
      name: "ProductSortKeys",
      description: "The set of valid sort keys for the products query.",
      values: [
        {
          name: "TITLE",
          description: "Sort by the `title` value.",
        },
        {
          name: "PRODUCT_TYPE",
          description: "Sort by the `product_type` value.",
        },
        {
          name: "VENDOR",
          description: "Sort by the `vendor` value.",
        },
        {
          name: "INVENTORY_TOTAL",
          description: "Sort by the `inventory_total` value.",
        },
        {
          name: "UPDATED_AT",
          description: "Sort by the `updated_at` value.",
        },
        {
          name: "CREATED_AT",
          description: "Sort by the `created_at` value.",
        },
        {
          name: "PUBLISHED_AT",
          description: "Sort by the `published_at` value.",
        },
        {
          name: "ID",
          description: "Sort by the `id` value.",
        },
        {
          name: "RELEVANCE",
          description: "During a search (i.e. when the `query` parameter has been specified on the connection) this sorts the\nresults by relevance to the search term(s). When no search query is specified, this sort key is not\ndeterministic and should not be used.\n",
        },
      ],
    )
    data = Falsify.parse_json(file_fixture("introspection-json/enum3.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_enum(data)
    assert_equal(want, have)
  end

end
