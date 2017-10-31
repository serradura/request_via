# frozen_string_literal: true

module  Support
  module Assertions
    module To
      HTTPMethod = -> (http_method, context:) {
        -> use_case {
          assertion = Support::Assertions.const_get(use_case)
          assertion.new(context, http_method: http_method)
        }
      }.curry.freeze

      Get = HTTPMethod.(:get).freeze

      Head = HTTPMethod.(:head).freeze

      Post = HTTPMethod.(:post).freeze

      Put = HTTPMethod.(:put).freeze

      Delete = HTTPMethod.(:delete).freeze

      Options = HTTPMethod.(:options).freeze

      Trace = HTTPMethod.(:trace).freeze

      Patch = HTTPMethod.(:patch).freeze
    end
  end
end
