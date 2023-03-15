# frozen_string_literal: true

RSpec.describe Fedex::Ws::BaseRequest do
  subject(:request) { described_class.new }

  describe '#xml' do
    it 'raises an error' do
      expect { request.xml }.to raise_error(NotImplementedError)
    end
  end

  describe '#call' do
    it 'raises an error' do
      expect { request.call }.to raise_error(NotImplementedError)
    end
  end
end
