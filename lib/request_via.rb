# frozen_string_literal: true

require 'net/https'
require 'uri'

require "request_via/version"
require "request_via/http_client"
require "request_via/func"

module RequestVia
  Get     = Func::FetchStrategyTo.(Net::HTTP::Get)
  Head    = Func::FetchStrategyTo.(Net::HTTP::Head)
  Post    = Func::FetchStrategyTo.(Net::HTTP::Post)
  Put     = Func::FetchStrategyTo.(Net::HTTP::Put)
  Delete  = Func::FetchStrategyTo.(Net::HTTP::Delete)
  Options = Func::FetchStrategyTo.(Net::HTTP::Options)
  Trace   = Func::FetchStrategyTo.(Net::HTTP::Trace)
  Patch   = Func::FetchStrategyTo.(Net::HTTP::Patch)

  GetR     = Func::ReverseRequestArgsTo.(Get)
  HeadR    = Func::ReverseRequestArgsTo.(Head)
  PostR    = Func::ReverseRequestArgsTo.(Post)
  PutR     = Func::ReverseRequestArgsTo.(Put)
  DeleteR  = Func::ReverseRequestArgsTo.(Delete)
  OptionsR = Func::ReverseRequestArgsTo.(Options)
  TraceR   = Func::ReverseRequestArgsTo.(Trace)
  PatchR   = Func::ReverseRequestArgsTo.(Patch)
end
