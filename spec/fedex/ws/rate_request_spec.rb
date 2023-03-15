# frozen_string_literal: true

RSpec.describe Fedex::Ws::RateRequest do
  subject(:request) { described_class.new(credentials: credentials, params: params) }

  include_context 'with credentials'
  include_context 'with params'

  describe '#xml' do
    it 'builds the xml for the request' do
      expect(request.xml).to eq(file_fixture('rate_request.xml'))
    end
  end
end
