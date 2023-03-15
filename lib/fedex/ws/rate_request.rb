# frozen_string_literal: true

module Fedex
  module Ws
    class RateRequest < BaseRequest
      def xml
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.RateRequest(xmlns: 'http://fedex.com/ws/rate/v13') do
            add_web_authentication_detail_tag(xml)
            add_client_detail_tag(xml)
            add_version_tag(xml)
            add_return_transit_and_commit_tag(xml)
            add_requested_shipment_tag(xml)
          end
        end
        builder.doc.root.to_xml
      end

      def call
        response = HTTParty.post(base_url, body: xml)
        Parser::RateReply.call(response.parsed_response)
      end

      private

      def add_return_transit_and_commit_tag(xml)
        xml.ReturnTransitAndCommit(true)
      end

      def add_requested_shipment_tag(xml)
        xml.RequestedShipment do
          xml.DropoffType('REGULAR_PICKUP')
          xml.PackagingType('YOUR_PACKAGING')
          xml.Shipper { add_address_tag(xml, params.fetch(:shipper_address, {})) }
          xml.Recipient { add_address_tag(xml, params.fetch(:recipient_address, {})) }
          xml.ShippingChargesPayment { xml.PaymentType('SENDER') }
          xml.RateRequestTypes('ACCOUNT')
          add_requested_package_line_items_tag(xml)
        end
      end

      def add_address_tag(xml, address)
        xml.Address do
          xml.StreetLines
          xml.City
          xml.StateOrProvinceCode('XX')
          xml.PostalCode(address.fetch(:postal_code, ''))
          xml.CountryCode(address.fetch(:country_code, ''))
        end
      end

      def add_requested_package_line_items_tag(xml)
        xml.PackageCount(1)
        xml.RequestedPackageLineItems do
          xml.GroupPackageCount(1)
          add_weight_tag(xml, params.fetch(:package, {}))
          add_dimensions_tag(xml, params.fetch(:package, {}))
        end
      end

      def add_weight_tag(xml, package)
        weight = package.fetch(:weight, {})
        xml.Weight do
          xml.Units(weight.fetch(:units, ''))
          xml.Value(weight.fetch(:value, ''))
        end
      end

      def add_dimensions_tag(xml, package)
        dimensions = package.fetch(:dimensions, {})
        xml.Dimensions do
          xml.Length(dimensions.fetch(:length, ''))
          xml.Width(dimensions.fetch(:width, ''))
          xml.Height(dimensions.fetch(:height, ''))
          xml.Units(dimensions.fetch(:units, ''))
        end
      end
    end
  end
end
