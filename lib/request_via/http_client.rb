# encoding: UTF-8
# frozen_string_literal: true

module RequestVia
  module HttpClient
    extend self

    def call(uri)
      net_http = Net::HTTP.new(uri.host, uri.port)

      URI.https?(uri) ? set_https!(net_http) : net_http
    end

    private

    def set_https!(net_http)
      net_http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      net_http.use_ssl = true
      net_http
    end
  end
end
