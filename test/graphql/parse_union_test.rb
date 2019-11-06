require "test_helper"

class ParseUnionEnum < Minitest::Test

  def test_parse_union1
    want = {
      name: "DiscountCode",
      description: "A code discount.",
      types: [
        "DiscountCodeBasic",
        "DiscountCodeBxgy",
        "DiscountCodeFreeShipping",
      ],
    }
    data = Falsify.parse_json(file_fixture("introspection-json/union1.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_union(data)
    assert_equal(want, have)
  end

  def test_parse_union2
    want = {
      name: "DiscountEffect",
      description: "The type of discount that will be applied. Currently, only percentage off is supported.",
      types: ["DiscountPercentage"],
    }
    data = Falsify.parse_json(file_fixture("introspection-json/union2.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_union(data)
    assert_equal(want, have)
  end

  def test_parse_union3
    want = {
      name: "CommentEventEmbed",
      description: "The main embed of a comment event.",
      types: [
        "Order",
        "DraftOrder",
        "Customer",
        "Product",
        "ProductVariant",
      ],
    }
    data = Falsify.parse_json(file_fixture("introspection-json/union3.json"))
    have = Falsify::Build::GraphQL::Parser.new().parse_union(data)
    assert_equal(want, have)
  end

end
