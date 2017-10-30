# frozen_string_literal: true

module  Support

  module Func
    IsOK = -> response {
      response.code == '200'
    }.freeze

    HTTPMethodConstOf = -> (object, http_method) {
      object.const_get String(http_method).capitalize
    }.freeze

    GetRequestViaHTTPMethod = -> http_method {
      HTTPMethodConstOf.(RequestVia, http_method)
    }.freeze

    StringifyKeysAndValues = -> hash {
      return hash if hash.empty?

      hash.reduce({}) do |memo, (key, value)|
        memo.update String(key) => String(value)
      end
    }.freeze

    MockDataToRequest = -> (params_key, params, headers) {
      Hash.new.tap do |stub_data|
        stub_data[:headers] = StringifyKeysAndValues.(headers) unless headers.empty?
        stub_data[params_key] = StringifyKeysAndValues.(params) unless params.empty?
      end
    }.curry.freeze

    MockDataToRequestWithBody = MockDataToRequest.(:body).freeze
    MockDataToRequestWithQuery = MockDataToRequest.(:query).freeze
  end

end
