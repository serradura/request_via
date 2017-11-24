# frozen_string_literal: true

module RequestVia
  module Func

    ReverseRequestArgsTo = -> request {
      -> (options, url) {
        request.(url, **options)
      }.curry
    }

    ParseURI = -> url {
      if url.start_with?('http://', 'https://')
        ::URI.parse(url)
      elsif /([^:]+)?:?\/\// !~ url
        ::URI.parse("http://#{url}")
      else
        fail ::URI::InvalidURIError, 'URI scheme must be http:// or https://'
      end
    }

    IsAHash = -> data {
      data.is_a?(::Hash)
    }

    SetRequestHeaders = -> (request, headers) {
      request_headers = IsAHash.(headers) ? headers : {}

      DEFAULT_HEADERS.merge(request_headers).each do |key, value|
        request[key] = value
      end

      return request
    }

    URIWithoutParams = -> (url, _) {
      ParseURI.(url)
    }

    URIWithParams = -> (url, params) {
      ParseURI.(url).tap do |uri|
        uri.query = ::URI.encode_www_form(params) if IsAHash.(params)
      end
    }

    RequestWithoutBody = -> http_method {
      -> (uri, _) { http_method.new(uri) }
    }

    RequestWithBody = -> http_method {
      -> (uri, params) {
        req = http_method.new(uri)
        req.set_form_data(params) if IsAHash.(params)
        return req
      }
    }

    FetchWith = -> (uri_builder, request_builder) {
      -> (url, port: nil,
               params: nil,
               headers: nil,
               net_http: nil,
               open_timeout: nil,
               read_timeout: nil,
               response_and_request: false) do
        uri = uri_builder.(url, params)
        req = SetRequestHeaders.(request_builder.(uri, params), headers)
        http = NetHTTP.(uri, port, open_timeout, read_timeout, net_http)
        response = http.request(req)
        response_and_request ? [response, req] : response
      end
    }

    FetchWithBodyVia = -> http_method {
      FetchWith.(URIWithoutParams, RequestWithBody.(http_method))
    }

    FetchWithQueryStringVia = -> http_method {
      FetchWith.(URIWithParams, RequestWithoutBody.(http_method))
    }

    FetchStrategyTo = -> http_method {
      strategy_to = \
        http_method::REQUEST_HAS_BODY ? FetchWithBodyVia : FetchWithQueryStringVia

      strategy_to.(http_method)
    }

  end
end
