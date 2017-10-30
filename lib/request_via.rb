# frozen_string_literal: true

require 'net/https'
require 'uri'

require "request_via/version"
require "request_via/http_client/uri"
require "request_via/http_client"
require "request_via/func"

module RequestVia
  Get = Func::FetchWithQueryStringVia.(Net::HTTP::Get)

  Put = Func::FetchWithBodyVia.(Net::HTTP::Put)

  Post = Func::FetchWithBodyVia.(Net::HTTP::Post)

  Delete = Func::FetchWithQueryStringVia.(Net::HTTP::Delete)
end
