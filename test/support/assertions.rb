# frozen_string_literal: true

module  Support
  module Assertions
    module To
      HTTPMethod = -> (http_method, context:) {
        -> use_case {
          assertion = Support::Assertions.const_get(use_case)
          assertion.new(context, http_method: http_method)
        }.freeze
      }.curry.freeze

      Get     = HTTPMethod.(:get)
      Head    = HTTPMethod.(:head)
      Post    = HTTPMethod.(:post)
      Put     = HTTPMethod.(:put)
      Delete  = HTTPMethod.(:delete)
      Options = HTTPMethod.(:options)
      Trace   = HTTPMethod.(:trace)
      Patch   = HTTPMethod.(:patch)
    end
  end
end
