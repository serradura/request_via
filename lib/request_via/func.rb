# frozen_string_literal: true

module RequestVia
  Freeze = -> object { object.freeze }.freeze

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
      return request unless IsAHash.(headers)
      headers.each { |key, value| request[key] = value }
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
      -> (url, params: nil, headers: nil, response_and_request: false) {
        uri = uri_builder.(url, params)
        req = SetRequestHeaders.(request_builder.(uri, params), headers)
        res = HTTPClient.(uri).request(req)
        response_and_request ? [res, req] : res
      }
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
