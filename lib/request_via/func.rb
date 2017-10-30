# encoding: UTF-8
# frozen_string_literal: true

module RequestVia
  module Func
    ParseURI = -> url { HttpClient::URI.parse!(url) }.freeze

    IsAHash = -> data { data.is_a?(::Hash) }.freeze

    SetRequestHeaders = -> (request, headers) {
      return request unless IsAHash.(headers)
      headers.each { |key, value| request[key] = value }
      return request
    }.freeze

    URIWithoutParams = -> (url, _) { ParseURI.(url) }.freeze

    URIWithParams = -> (url, params) {
      ParseURI.(url).tap do |uri|
        uri.query = ::URI.encode_www_form(params) if IsAHash.(params)
      end
    }.freeze

    RequestWithoutBody = -> http_method {
      -> (uri, _) { http_method.new(uri) }
    }.freeze

    RequestWithBody = -> http_method {
      -> (uri, params) {
        req = http_method.new(uri)
        req.set_form_data(params) if IsAHash.(params)
        return req
      }
    }.freeze

    FetchWith = -> (uri_builder, request_builder) {
      -> (url, params: nil, headers: nil, response_and_request: false) {
        uri = uri_builder.(url, params)
        req = SetRequestHeaders.(request_builder.(uri, params), headers)
        res = HttpClient.(uri).request(req)
        response_and_request ? [res, req] : res
      }
    }.freeze

    FetchWithBodyVia = -> http_method {
      FetchWith.(URIWithoutParams, RequestWithBody.(http_method)).freeze
    }.freeze

    FetchWithQueryStringVia = -> http_method {
      FetchWith.(URIWithParams, RequestWithoutBody.(http_method)).freeze
    }.freeze
  end
end
