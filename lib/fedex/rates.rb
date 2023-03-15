# frozen_string_literal: true

module Fedex
  class Rates
    def self.get(credentials, quote_params)
      params = Fedex::Mapper::RateRequestInput.call(quote_params)
      rates = Fedex::Ws::RateRequest.new(credentials: credentials, params: params).call
      Fedex::Mapper::RateRequestOutput.call(rates)
    end
  end
end
