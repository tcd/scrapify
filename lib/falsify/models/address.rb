module Falsify
  # Used for:
  # - Order.billing_address
  # - Order.shipping_address
  class Address
    # @!attribute address1 [rw]
    #   The street address of the billing address.
    #   @return [String]
    attr_accessor :address1
    # @!attribute address2 [rw]
    #   An optional additional field for the street address of the billing address.
    #   @return [String]
    attr_accessor :address2
    # @!attribute city [rw]
    #   The city, town, or village of the billing address.
    #   @return [String]
    attr_accessor :city
    # @!attribute company [rw]
    #   The company of the person associated with the billing address.
    #   @return [String]
    attr_accessor :company
    # @!attribute country [rw]
    #   The name of the country of the billing address.
    #   @return [String]
    attr_accessor :country
    # @!attribute country_code [r]
    #   The two-letter code ([ISO 3166-1](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) format) for the country of the billing address.
    #   @return [String]
    attr_accessor :country_code
    # @!attribute first_name [rw]
    #   The first name of the person associated with the payment method.
    #   @return [String]
    attr_accessor :first_name
    # @!attribute last_name [rw]
    #   The last name of the person associated with the payment method.
    #   @return [String]
    attr_accessor :last_name
    # @!attribute latitude [rw]
    #   The latitude of the billing address.
    #   @return [String]
    attr_accessor :latitude
    # @!attribute longitude [rw]
    #   The longitude of the billing address.
    #   @return [String]
    attr_accessor :longitude
    # @!attribute name [rw]
    #   The full name of the person associated with the payment method.
    #   @return [String]
    attr_accessor :name
    # @!attribute phone [rw]
    #   The phone number at the billing address.
    #   @return [String]
    attr_accessor :phone
    # @!attribute province [rw]
    #   The name of the region (province, state, prefecture, ...) of the billing address.
    #   @return [String]
    attr_accessor :province
    # @!attribute province_code [r]
    #   The two-letter abbreviation of the region of the billing address.
    #   @return [String]
    attr_accessor :province_code
    # @!attribute zip [rw]
    #   The postal code (zip, postcode, Eircode, ...) of the billing address.
    #   @return [String]
    attr_accessor :zip
  end
end
