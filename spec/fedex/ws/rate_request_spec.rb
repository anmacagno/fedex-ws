# frozen_string_literal: true

require 'active_support/all'

RSpec.describe Fedex::Ws::RateRequest do
  subject(:request) { described_class.new(credentials: credentials, params: params) }

  include_context 'with credentials'
  include_context 'with params'

  describe '#xml' do
    it 'builds the xml for the request' do
      expect(request.xml).to eq(file_fixture('rate_request.xml'))
    end
  end

  describe '#call' do
    before do
      parsed_response = Hash.from_xml(file_fixture('rate_reply.xml'))
      allow(HTTParty).to receive(:post).and_return(
        instance_double(HTTParty::Response, parsed_response: parsed_response)
      )
    end

    it 'returns 3 rates' do
      expect(request.call.size).to eq(3)
    end
  end
end
