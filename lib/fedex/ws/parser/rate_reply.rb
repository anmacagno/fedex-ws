# frozen_string_literal: true

module Fedex
  module Ws
    module Parser
      class RateReply
        SEVERITY_CODES = %w[SUCCESS WARNING].freeze

        def self.call(parsed_response)
          rate_reply = find_rate_reply(parsed_response)
          parse_rate_reply_details(rate_reply['RateReplyDetails'])
        end

        def self.find_rate_reply(parsed_response)
          rate_reply = parsed_response['RateReply']
          raise(ParserError, parsed_response['CSRError']['message']) if parsed_response['CSRError']
          raise(ParserError, "The tag RateReply is not present: #{parsed_response}") unless rate_reply
          raise(ParserError, rate_reply['Notifications']['Message']) unless SEVERITY_CODES.include?(
            rate_reply['HighestSeverity']
          )

          rate_reply
        end

        def self.parse_rate_reply_details(rate_reply_details)
          rate_reply_details.each_with_object([]) do |rate_reply_detail, array|
            rated_shipment_details = parse_rated_shipment_details(rate_reply_detail['RatedShipmentDetails'])
            array << {
              service_type: rate_reply_detail['ServiceType'],
              rated_shipment_details: rated_shipment_details
            }
          end
        end

        def self.parse_rated_shipment_details(rated_shipment_details)
          rated_shipment_details.each_with_object([]) do |rated_shipment_detail, array|
            total_net_charge = rated_shipment_detail['ShipmentRateDetail']['TotalNetChargeWithDutiesAndTaxes']
            array << {
              currency: total_net_charge['Currency'],
              amount: total_net_charge['Amount']
            }
          end
        end
      end
    end
  end
end
