$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "request_via"

require "minitest/autorun"
require 'webmock/minitest'

require_relative 'support/routes'
require_relative 'support/request_without_protocol'
