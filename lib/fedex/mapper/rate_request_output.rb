# frozen_string_literal: true

module Fedex
  module Mapper
    class RateRequestOutput
      require 'active_support/core_ext/string'

      def self.call(rates)
        rates.each_with_object([]) do |rate, array|
          next unless rate[:service_type].present?

          rate[:rated_shipment_details].each do |shipment|
            next unless shipment[:currency] == 'MXN'

            array << output(rate, shipment)
          end
        end
      end

      def self.output(rate, shipment)
        {
          price: shipment[:amount]&.to_f,
          currency: shipment[:currency],
          service_level: {
            name: rate[:service_type].titleize,
            token: rate[:service_type]
          }
        }
      end
    end
  end
end
