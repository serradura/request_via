# frozen_string_literal: true

module RequestVia
  module NetHTTP
    extend self

    Build = Freeze.(-> (host, port) {
      Net::HTTP.new(host, port)
    })

    IsNetHTTP = Freeze.(-> object {
      object.instance_of?(Net::HTTP)
    })

    def call(uri, port = nil, open_timeout = nil, read_timeout = nil, net_http = nil)
      return net_http if IsNetHTTP.(net_http)

      net_http = build!(uri, port, net_http)

      net_http.open_timeout = Integer(open_timeout) unless open_timeout.nil?
      net_http.read_timeout = Integer(read_timeout) unless read_timeout.nil?

      return net_http unless uri.instance_of?(URI::HTTPS)

      set_https!(net_http)
    end

    private

    def build!(uri, port, net_http)
      strategy = net_http.is_a?(Proc) ? net_http : Build

      http = strategy.(uri.host, (port || uri.port))

      return http if IsNetHTTP.(http)

      fail TypeError, 'net_http proc must return a Net:HTTP instance'
    end

    def set_https!(net_http)
      net_http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      net_http.use_ssl = true
      net_http
    end
  end
end
