# encoding: UTF-8
# frozen_string_literal: true

require 'net/https'
require 'uri'

require "request_via/version"
require "request_via/http/uri"
require "request_via/http"
require "request_via/func"

module RequestVia
  Get = Func::FetchWithQueryStringVia.(Net::HTTP::Get)

  Put = Func::FetchWithBodyVia.(Net::HTTP::Put)

  Post = Func::FetchWithBodyVia.(Net::HTTP::Post)

  Delete = Func::FetchWithQueryStringVia.(Net::HTTP::Delete)
end
