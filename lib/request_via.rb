# frozen_string_literal: true

require 'net/https'
require 'uri'

require "request_via/version"
require "request_via/http_client"
require "request_via/func"

module RequestVia
  Get = Func::FetchWithQueryStringVia.(Net::HTTP::Get).freeze

  Put = Func::FetchWithBodyVia.(Net::HTTP::Put).freeze

  Post = Func::FetchWithBodyVia.(Net::HTTP::Post).freeze

  Delete = Func::FetchWithQueryStringVia.(Net::HTTP::Delete).freeze
end
