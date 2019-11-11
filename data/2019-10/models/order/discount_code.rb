module Falsify
  # Discount codes to be applied to an order.
  class DiscountCode
    # @!attribute amount [rw]
    #   The value of the discount to be deducted from the order total.
    #   The `type` field determines how this value is calculated.
    #   After an order is created, this field returns the calculated amount.
    attr_accessor :amount
    # @!attribute code [rw]
    #   The discount code.
    attr_accessor :code
    # @!attribute type [rw]
    #   The type of discount.
    #   Default value: `fixed_amount`.
    #   Valid values:
    #   - `fixed_amount`: Applies `amount ` as a unit of the store's currency. For example, if `amount` is 30 and the store's currency is USD, then 30 USD is deducted from the order total when the discount is applied.
    #   - `percentage`: Applies a discount of `amount` as a percentage of the order total.
    #   - `shipping`: Applies a free shipping discount on orders that have a shipping rate less than or equal to `amount`. For example, if `amount` is 30, then the discount will give the customer free shipping for any shipping rate that is less than or equal to $30.
    #   @return [:fixed_amount, :percentage, :shipping]
    # enum status: [:fixed_amount, :percentage, :shipping]
  end
end
