# frozen_string_literal: true

module Fedex
  module Mapper
    class RateRequestInput
      def self.call(params)
        parcel = params[:parcel] || {}
        {
          shipper_address: address(params[:address_from] || {}),
          recipient_address: address(params[:address_to] || {}),
          package: {
            weight: package_weight(parcel),
            dimensions: package_dimensions(parcel)
          }
        }
      end

      def self.address(address)
        {
          postal_code: address[:zip],
          country_code: address[:country]&.upcase
        }
      end

      def self.package_weight(parcel)
        {
          units: parcel[:mass_unit]&.upcase,
          value: parcel[:weight]
        }
      end

      def self.package_dimensions(parcel)
        {
          length: parcel[:length]&.to_i,
          width: parcel[:width]&.to_i,
          height: parcel[:height]&.to_i,
          units: parcel[:distance_unit]&.upcase
        }
      end
    end
  end
end
