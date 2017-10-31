$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "request_via"

require "minitest/autorun"
require 'webmock/minitest'

require_relative 'support/func'
require_relative 'support/routes'
require_relative 'support/assertions'
require_relative 'support/assertions/base'
require_relative 'support/assertions/request_with_body'
require_relative 'support/assertions/request_with_query'
require_relative 'support/assertions/request_with_reversed_method_version'
require_relative 'support/assertions/request_without_protocol'
require_relative 'support/assertions/response_and_request_option'
