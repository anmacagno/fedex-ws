# frozen_string_literal: true

require_relative 'rates'
require_relative 'mapper/rate_request_input'
require_relative 'mapper/rate_request_output'
require_relative 'ws/base_request'
require_relative 'ws/rate_request'
require_relative 'ws/parser/rate_reply'
require_relative 'ws/version'

module Fedex
  module Ws
    class Error < StandardError; end

    class ParserError < Error; end
  end
end
