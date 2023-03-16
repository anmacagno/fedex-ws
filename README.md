# FedEx WS

The objective of this project is the implementation of a client that returns the rates available for a shipment using a FedEx web service.

With this development I want to show some of my skills as a software engineer.

### Prerequisites

- Ruby 3.1.3
- Bundler 2.4.8

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'fedex-ws', '~> 0.1', github: 'anmacagno/fedex-ws'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install fedex-ws
```

### Usage

```ruby
credentials = {
  key: 'your_key',
  password: 'your_password',
  account_number: 'your_account_number',
  meter_number: 'your_meter_number'
}

quote_params = {
  address_from: {
    zip: '64000',
    country: 'mx'
  },
  address_to: {
    zip: '64000',
    country: 'mx'
  },
  parcel: {
    length: 25.0,
    width: 28.0,
    height: 46.0,
    distance_unit: 'cm',
    weight: 6.5,
    mass_unit: 'kg'
  }
}

rates = Fedex::Rates.get(credentials, quote_params)
```

### Example response

```ruby
[
  {
    :price=>524.71,
    :currency=>"MXN",
    :service_level=>{
      :name=>"Priority Overnight",
      :token=>"PRIORITY_OVERNIGHT"
    }
  },
  {
    :price=>418.49,
    :currency=>"MXN",
    :service_level=>{
      :name=>"Standard Overnight",
      :token=>"STANDARD_OVERNIGHT"
    }
  },
  {
    :price=>266.16,
    :currency=>"MXN",
    :service_level=>{
      :name=>"Fedex Express Saver",
      :token=>"FEDEX_EXPRESS_SAVER"
    }
  }
]
```
