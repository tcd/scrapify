module Falsify
  # An amount allocated by discount applications.
  # Each discount allocation is associated to a particular discount application.
  class DiscountAllocation
    # @!attribute amount [rw]
    #   The discount amount allocated to the line in the shop currency.
    #   @return [String]
    attr_accessor :amount
    # @!attribute discount_application_index [rw]
    #   The index of the associated discount application in the order's discount_applications list.
    #   @return [String]
    attr_accessor :discount_application_index
    # @!attribute amount_set [rw]
    #   The discount amount allocated to the line item in shop and presentment currencies.
    #   @return [PriceSet]
    attr_accessor :amount_set
  end
end
