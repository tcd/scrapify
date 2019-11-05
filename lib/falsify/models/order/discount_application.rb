module Falsify
  # An ordered list of stacked discount applications.
  # The `discount_applications` property includes 3 types: `discount_code`, `manual`, and `script`.
  # All 3 types share a common structure and have some type specific attributes.
  class DiscountApplication
    # @!attribute allocation_method [rw]
    #   The method by which the discount application value has been allocated to entitled lines.
    #   - `across`: The value is spread across all entitled lines.
    #   - `each`: The value is applied onto every entitled line.
    #   - `one`: The value is applied onto a single line.
    #   @return [:across, :each, :one]
    # enum allocation_method: [:across, :each, :one]
    # @!attribute code [rw]
    #   The discount code that was used to apply the discount.
    #   Available only for discount code applications.
    #   @return [String]
    attr_accessor :code
    # @!attribute description [rw]
    #   The description of the discount application, as defined by the merchant or the Shopify Script.
    #   Available only for manual and script discount applications.
    #   @return [String]
    attr_accessor :description
    # @!attribute target_selection [rw]
    #   The lines on the order, of the type defined by `target_type`, that the discount is allocated over.
    #   - `all`: The discount is allocated onto all lines,
    #   - `entitled`: The discount is allocated only onto lines it is entitled for.
    #   - `explicit`: The discount is allocated onto explicitly selected lines.
    #   @return [:all, :entitled, :explicit]
    # enum target_selection: [:all, :entitled, :explicit]
    # @!attribute target_type [rw]
    #   The type of line on the order that the discount is applicable on.
    #   Valid values:
    #   - `line_item`: The discount applies to line items.
    #   - `shipping_line`: The discount applies to shipping lines.
    #   @return [:line_item, :shipping_line]
    # enum target_selection: [:line_item, :shipping_line]
    # @!attribute title [rw]
    #   The title of the discount application, as defined by the merchant.
    #   Available only for manual discount applications.
    #   @return [String]
    attr_accessor :title
    # @!attribute type [rw]
    #   The discount application type.
    #   - `manual`: The discount was manually applied by the merchant (for example, by using an app or creating a draft order).
    #   - `script`: The discount was applied by a Shopify Script.
    #   - `discount_code`: The discount was applied by a discount code.
    #   @return [:manual, :script, :discount_code]
    # enum type:  [:manual, :script, :discount_code]
    # @!attribute value [rw]
    #   The value of the discount application as a decimal.
    #   This represents the intention of the discount application.
    #   For example, if the intent was to apply a 20% discount, then the value will be `20.0`.
    #   If the intent was to apply a $15 discount, then the value will be `15.0`.
    #   @return [String]
    attr_accessor :value
    # @!attribute value_type [rw]
    #   The type of the value.
    #   - `fixed_amount`: A fixed amount discount value in the currency of the order.
    #   - `percentage`: A percentage discount value.
    # enum value_type: [:fixed_amount, :percentage]
  end
end
