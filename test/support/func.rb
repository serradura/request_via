# frozen_string_literal: true

module  Support

  module Func
    IsOK = -> response {
      response.code == '200'
    }

    Capitalize = -> value {
      String(value).capitalize
    }

    HTTPMethodConstOf = -> (object, constant) {
      object.const_get constant
    }

    GetNetHTTPMethod  = -> http_method {
      HTTPMethodConstOf.(Net::HTTP, Capitalize.(http_method))
    }

    GetRequestViaHTTPMethod = -> http_method {
      HTTPMethodConstOf.(RequestVia, Capitalize.(http_method))
    }

    GetReversedHTTPMethodVersion = -> http_method {
      HTTPMethodConstOf.(RequestVia, "#{Capitalize.(http_method)}R")
    }

    StringifyKeysAndValues = -> hash {
      return hash if hash.empty?

      hash.reduce({}) do |memo, (key, value)|
        memo.update String(key) => String(value)
      end
    }

    MockDataToRequest = -> (params_key, params, headers) {
      Hash.new.tap do |stub_data|
        stub_data[:headers] = StringifyKeysAndValues.(headers) unless headers.empty?
        stub_data[params_key] = StringifyKeysAndValues.(params) unless params.empty?
      end
    }.curry

    MockDataToRequestWithBody =
      MockDataToRequest.(:body).freeze

    MockDataToRequestWithQuery =
      MockDataToRequest.(:query).freeze

    MockDataToRequestVia = -> http_method {
      if GetNetHTTPMethod.(http_method)::REQUEST_HAS_BODY
        MockDataToRequestWithBody
      else
        MockDataToRequestWithQuery
      end
    }
  end

end
