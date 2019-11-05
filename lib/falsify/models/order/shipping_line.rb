module Falsify
  # An individual shipping method used to fulfill an order.
  class ShippingLine
    # @!attribute code [rw]
    #   A reference to the shipping method.
    #   @return [String]
    attr_accessor :code
    # @!attribute discounted_price [rw]
    #   The price of the shipping method after line-level discounts have been applied.
    #   Doesn't reflect cart-level or order-level discounts.
    #   @return [String]
    attr_accessor :discounted_price
    # @!attribute discounted_price_set [rw]
    #   The price of the shipping method in both shop and presentment currencies after line-level discounts have been applied.
    #   @return [PriceSet]
    attr_accessor :discounted_price_set
    # @!attribute price [rw]
    #   The price of this shipping method in the shop currency.
    #   Can't be negative.
    #   @return [String]
    attr_accessor :price
    # @!attribute price_set [rw]
    #   The price of the shipping method in shop and presentment currencies.
    #   @return [PriceSet]
    attr_accessor :price_set
    # @!attribute source [rw]
    #   The source of the shipping method.
    #   @return [String]
    attr_accessor :source
    # @!attribute title [rw]
    #   The title of the shipping method.
    #   @return [String]
    attr_accessor :title
    # @!attribute tax_lines [rw]
    #   A list of tax line objects, each of which details a tax applicable to this shipping line.
    #   @return [Array<TaxLine>]
    attr_accessor :tax_lines
    # @!attribute carrier_identifier [rw]
    #   A reference to the carrier service that provided the rate.
    #   Present when the rate was computed by a third-party carrier service.
    #   @return [String]
    attr_accessor :carrier_identifier
    # @!attribute requested_fulfillment_service_id [rw]
    #   A reference to the fulfillment service that is being requested for the shipping method.
    #   Present if the shipping method requires processing by a third party fulfillment service; null otherwise.
    #   @return [String]
    attr_accessor :requested_fulfillment_service_id
  end
end
