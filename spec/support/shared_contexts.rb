# frozen_string_literal: true

RSpec.shared_context 'with credentials' do
  let(:credentials) do
    {
      key: 'your_key',
      password: 'your_password',
      account_number: 'your_account_number',
      meter_number: 'your_meter_number'
    }
  end
end

RSpec.shared_context 'with params' do
  let(:params) do
    {
      shipper_address: {
        postal_code: '64000',
        country_code: 'MX'
      },
      recipient_address: {
        postal_code: '44160',
        country_code: 'MX'
      },
      package: {
        weight: {
          units: 'KG',
          value: '1'
        },
        dimensions: {
          length: '10',
          width: '10',
          height: '10',
          units: 'CM'
        }
      }
    }
  end
end
