# frozen_string_literal: true

module Fedex
  module Ws
    class BaseRequest
      require 'httparty'
      require 'nokogiri'

      BASE_URL = 'https://wsbeta.fedex.com:443/xml'

      attr_reader :credentials, :params, :base_url

      def initialize(credentials: {}, params: {}, base_url: BASE_URL)
        @credentials = credentials
        @params = params
        @base_url = base_url
      end

      def xml
        raise NotImplementedError
      end

      def call
        raise NotImplementedError
      end

      private

      def add_web_authentication_detail_tag(xml)
        xml.WebAuthenticationDetail do
          xml.UserCredential do
            xml.Key(credentials.fetch(:key, ''))
            xml.Password(credentials.fetch(:password, ''))
          end
        end
      end

      def add_client_detail_tag(xml)
        xml.ClientDetail do
          xml.AccountNumber(credentials.fetch(:account_number, ''))
          xml.MeterNumber(credentials.fetch(:meter_number, ''))
          xml.Localization do
            xml.LanguageCode('es')
            xml.LocaleCode('mx')
          end
        end
      end

      def add_version_tag(xml)
        xml.Version do
          xml.ServiceId('crs')
          xml.Major(13)
          xml.Intermediate(0)
          xml.Minor(0)
        end
      end
    end
  end
end
