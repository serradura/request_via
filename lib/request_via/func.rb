# frozen_string_literal: true

module RequestVia
  module Func
    ReverseRequestArgsTo = Freeze.(-> request {
      Freeze.(-> (options, url) {
        request.(url, **options)
      }.curry)
    })

    ParseURI = Freeze.(-> url {
      if url.start_with?('http://', 'https://')
        ::URI.parse(url)
      elsif /([^:]+)?:?\/\// !~ url
        ::URI.parse("http://#{url}")
      else
        fail ::URI::InvalidURIError, 'URI scheme must be http:// or https://'
      end
    })

    IsAHash = Freeze.(-> data {
      data.is_a?(::Hash)
    })

    SetRequestHeaders = Freeze.(-> (request, headers) {
      request_headers = IsAHash.(headers) ? headers : {}

      DEFAULT_HEADERS.merge(request_headers).each do |key, value|
        request[key] = value
      end

      return request
    })

    URIWithoutParams = Freeze.(-> (url, _) {
      ParseURI.(url)
    })

    URIWithParams = Freeze.(-> (url, params) {
      ParseURI.(url).tap do |uri|
        uri.query = ::URI.encode_www_form(params) if IsAHash.(params)
      end
    })

    RequestWithoutBody = Freeze.(-> http_method {
      -> (uri, _) { http_method.new(uri) }
    })

    RequestWithBody = Freeze.(-> http_method {
      -> (uri, params) {
        req = http_method.new(uri)
        req.set_form_data(params) if IsAHash.(params)
        return req
      }
    })

    FetchWith = Freeze.(-> (uri_builder, request_builder) {
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
    })

    FetchWithBodyVia = Freeze.(-> http_method {
      FetchWith.(URIWithoutParams, RequestWithBody.(http_method))
    })

    FetchWithQueryStringVia = Freeze.(-> http_method {
      FetchWith.(URIWithParams, RequestWithoutBody.(http_method))
    })

    FetchStrategyTo = Freeze.(-> http_method {
      strategy_to = \
        http_method::REQUEST_HAS_BODY ? FetchWithBodyVia : FetchWithQueryStringVia

      Freeze.(strategy_to.(http_method))
    })
  end
end
