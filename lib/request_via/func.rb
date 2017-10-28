# encoding: UTF-8
# frozen_string_literal: true

module RequestVia
  module Func
    ParseURI = -> url { Http::URI.parse!(url) }.freeze

    HttpClient = -> uri {
      Http.client(uri, Http::URI.https?(uri))
    }.freeze

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

    FetchWith = -> (uri_builder, request_builder) {
      -> (url, params: nil, headers: nil, response_and_request: false) {
        uri = uri_builder.(url, params)
        req = SetRequestHeaders.(request_builder.(uri, params), headers)
        res = HttpClient.(uri).request(req)
        response_and_request ? [res, req] : res
      }
    }.freeze

    RequestWithoutBody = -> verb {
      -> (uri, _) { verb.new(uri) }
    }.freeze

    RequestWithBody = -> verb {
      -> (uri, params) {
        req = verb.new(uri)
        req.set_form_data(params) if IsAHash.(params)
        return req
      }
    }.freeze

    FetchWithBodyVia = -> verb {
      FetchWith.(URIWithoutParams, RequestWithBody.(verb)).freeze
    }.freeze

    FetchWithQueryStringVia = -> verb {
      FetchWith.(URIWithParams, RequestWithoutBody.(verb)).freeze
    }.freeze
  end
end
