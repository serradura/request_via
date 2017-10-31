# frozen_string_literal: true

require 'net/https'
require 'uri'

require "request_via/version"
require "request_via/http_client"
require "request_via/func"

module RequestVia
  Get = Func::FetchStrategyTo.(Net::HTTP::Get).freeze

  Post = Func::FetchStrategyTo.(Net::HTTP::Post).freeze

  Put = Func::FetchStrategyTo.(Net::HTTP::Put).freeze

  Delete = Func::FetchStrategyTo.(Net::HTTP::Delete).freeze
end
