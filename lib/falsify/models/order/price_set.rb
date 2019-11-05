module Falsify
  # Used for:
  # - price_set
  # - discounted_price_set
  # - total_discounts_set
  # - total_line_items_price_set
  # - total_price_set
  # - total_tax_set
  # - discount_allocations.amount_set
  class PriceSet
    attr_accessor :shop_money_amount
    attr_accessor :shop_money_currency_code
    attr_accessor :presentment_money_amount
    attr_accessor :presentment_money_currency_code

    # @return [PriceSet]
    def self.create_from_hash(hash)
      ps = PriceSet.new()
      hash = hash.with_indifferent_access

      shop_money                  = hash[:shop_money]
      ps.shop_money_amount        = shop_money[:amount]
      ps.shop_money_currency_code = shop_money[:currency_code]

      presentment_money                  = hash[:presentment_money]
      ps.presentment_money_amount        = presentment_money[:amount]
      ps.presentment_money_currency_code = presentment_money[:currency_code]

      return ps
    end

    # @return [Hash]
    def to_hash()
      return {
        'shop_money': {
          "amount": @shop_money_amount,
          "currency_code": @shop_money_currency_code,
        },
        'presentment_money': {
          "amount": @presentment_money_amount,
          "currency_code": @presentment_money_currency_code,
        },
      }
    end
  end
end
