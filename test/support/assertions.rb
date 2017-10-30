# frozen_string_literal: true

module  Support
  module Assertions
    module To
      HttpMethod = -> (http_method, context:) {
        -> use_case {
          assertion = Support::Assertions.const_get(use_case)
          assertion.new(context, http_method: http_method)
        }
      }.curry.freeze

      Get = HttpMethod.(:get).freeze

      Post = HttpMethod.(:post).freeze

      Put = HttpMethod.(:put).freeze

      Delete = HttpMethod.(:delete).freeze
    end
  end
end
