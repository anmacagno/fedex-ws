# frozen_string_literal: true

require_relative 'lib/fedex/ws/version'

Gem::Specification.new do |spec|
  spec.name = 'fedex-ws'
  spec.version = Fedex::Ws::VERSION
  spec.authors = ['anmacagno']
  spec.email = ['anmacagno@gmail.com']

  spec.summary = 'Connector to FedEx WS'
  spec.description = 'Connector to FedEx WS implemented in Ruby'
  spec.required_ruby_version = '>= 3.1.3'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb']
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.22'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.5'

  spec.add_dependency 'activesupport', '~> 7.0'
  spec.add_dependency 'httparty', '~> 0.20'
  spec.add_dependency 'nokogiri', '~> 1.14'
end
