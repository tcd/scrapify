module Falsify
  # An individual item in an Order.
  #
  # Required Fields:
  # - variant_id
  # - quantity
  class LineItem
    # @!attribute fulfillable_quantity [rw]
    #   The amount available to fulfill, calculated as follows:
    #   `quantity - max(refunded_quantity, fulfilled_quantity) - pending_fulfilled_quantity - open_fulfilled_quantity`.
    #   @return [String]
    attr_accessor :fulfillable_quantity
    # @!attribute fulfillment_service [rw]
    #   The service provider that's fulfilling the item.
    #   Valid values: "manual", or the name of the provider, such as "amazon" or "shipwire".
    #   @return [String]
    attr_accessor :fulfillment_service
    # @!attribute fulfillment_status [rw]
    #   How far along an order is in terms line items fulfilled.
    #   - `:fulfilled` - Every line item in the order has been fulfilled.
    #   - `:null` - None of the line items in the order have been fulfilled.
    #   - `:partial` - At least one line item in the order has been fulfilled.
    #   - `:restocked` - Every line item in the order has been restocked and the order canceled.
    #   @return [:null, :fulfilled, :partial, :not_eligible]
    # enum fulfillment_status: [:null, :fulfilled, :partial, :not_eligible]
    # @!attribute grams [rw]
    #   The weight of the item in grams.
    #   @return [String]
    attr_accessor :grams
    # @!attribute shopify_id [rw]
    #   The ID of the line item.
    #   @return [String]
    attr_accessor :shopify_id
    # @!attribute price [rw]
    #   The price of the item before discounts have been applied in the shop currency.
    #   @return [String]
    attr_accessor :price
    # @!attribute price_set [rw]
    #   The price of the line item in shop and presentment currencies.
    #   @return [PriceSet]
    attr_accessor :price_set
    # @!attribute product_id [rw]
    #   The ID of the product that the line item belongs to.
    #   Can be null if the original product associated with the order is deleted at a later date.
    #   @return [String]
    attr_accessor :product_id
    # @!attribute quantity [rw]
    #   The number of items that were purchased.
    #   @return [Integer]
    attr_accessor :quantity
    # @!attribute requires_shipping [rw]
    #   Whether the item requires shipping.
    #   @return [Boolean]
    attr_accessor :requires_shipping
    # @!attribute sku [rw]
    #   The item's SKU (stock keeping unit).
    #   @return [String]
    attr_accessor :sku
    # @!attribute title [rw]
    #   The title of the product.
    #   @return [String]
    attr_accessor :title
    # @!attribute variant_id [rw]
    #   The ID of the product variant.
    #   @return [String]
    attr_accessor :variant_id
    # @!attribute variant_title [rw]
    #   The title of the product variant.
    #   @return [String]
    attr_accessor :variant_title
    # @!attribute vendor [rw]
    #   The name of the item's supplier.
    #   @return [String]
    attr_accessor :vendor
    # @!attribute name [rw]
    #   The name of the product variant.
    #   @return [String]
    attr_accessor :name
    # @!attribute gift_card [rw]
    #   Whether the item is a gift card.
    #   If true, then the item is not taxed or considered for shipping charges.
    #   @return [Boolean]
    attr_accessor :gift_card
    # @!attribute properties [rw]
    #   An array of custom information for the item that has been added to the cart.
    #   Often used to provide product customization options.
    #   For more information, see [Get customization information for products with line item properties](https://help.shopify.com/en/themes/customization/products/features/get-customization-information-for-products).
    #   @return [Array<Hash>]
    attr_accessor :properties
    # @!attribute taxable [rw]
    #   Whether the item was taxable.
    #   @return [Boolean]
    attr_accessor :taxable
    # @!attribute tax_lines [rw]
    #   A list of tax line objects, each of which details a tax applied to the item.
    #   @return [Array<TaxLine>]
    attr_accessor :tax_lines
    # @!attribute tip_payment_gateway [rw]
    #   The payment gateway used to tender the tip, such as shopify_payments.
    #   Present only on tips.
    #   @return [String]
    attr_accessor :tip_payment_gateway
    # @!attribute tip_payment_method [rw]
    #   The payment method used to tender the tip, such as Visa.
    #   Present only on tips.
    #   @return [String]
    attr_accessor :tip_payment_method
    # @!attribute total_discount [rw]
    #   The total discount amount applied to this line item in the shop currency.
    #   This value is not subtracted in the line item price.
    #   @return [String]
    attr_accessor :total_discount
    # @!attribute total_discount_set [rw]
    #   The total discount applied to the line item in shop and presentment currencies.
    #   @return [PriceSet]
    attr_accessor :total_discount_set
    # @!attribute discount_allocations [rw]
    #   An ordered list of amounts allocated by discount applications.
    #   Each discount allocation is associated to a particular discount application.
    #   @return [Array<DiscountAllocation>]
    attr_accessor :discount_allocations
  end
end
