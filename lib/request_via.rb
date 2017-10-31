# frozen_string_literal: true

require 'net/https'
require 'uri'

require "request_via/version"
require "request_via/http_client"
require "request_via/func"

module RequestVia
  Get     = Func::FetchStrategyTo.(Net::HTTP::Get).freeze
  Head    = Func::FetchStrategyTo.(Net::HTTP::Head).freeze
  Post    = Func::FetchStrategyTo.(Net::HTTP::Post).freeze
  Put     = Func::FetchStrategyTo.(Net::HTTP::Put).freeze
  Delete  = Func::FetchStrategyTo.(Net::HTTP::Delete).freeze
  Options = Func::FetchStrategyTo.(Net::HTTP::Options).freeze
  Trace   = Func::FetchStrategyTo.(Net::HTTP::Trace).freeze
  Patch   = Func::FetchStrategyTo.(Net::HTTP::Patch).freeze

  GetR     = Func::ReverseRequestArgsTo.(Get).freeze
  HeadR    = Func::ReverseRequestArgsTo.(Head).freeze
  PostR    = Func::ReverseRequestArgsTo.(Post).freeze
  PutR     = Func::ReverseRequestArgsTo.(Put).freeze
  DeleteR  = Func::ReverseRequestArgsTo.(Delete).freeze
  OptionsR = Func::ReverseRequestArgsTo.(Options).freeze
  TraceR   = Func::ReverseRequestArgsTo.(Trace).freeze
  PatchR   = Func::ReverseRequestArgsTo.(Patch).freeze
end
