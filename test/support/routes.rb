# frozen_string_literal: true

module  Support

  module Routes
    extend self

    HOSTS = {
      example_com: 'example.com',
      www_example_com: 'www.example.com'
    }.freeze

    HTTP = -> url {
      "http://#{url}"
    }.freeze

    HTTPS = -> url {
      "https://#{url}"
    }.freeze

    ResolveProtocol = -> protocol {
      String(protocol == false ? '' : protocol)
        .strip
        .downcase
    }.freeze

    BuildRoute = -> (host, protocol) {
      case ResolveProtocol.(protocol)
      when '' then host
      when 'http' then HTTP.(host)
      when 'https' then HTTPS.(host)
      else fail NotImplementedError
      end
    }.freeze

    To = -> (protocol, host) {
      BuildRoute.(self[host], protocol)
    }.curry.freeze

    def [](host)
      HOSTS.fetch(host)
    end
    alias_method :without_protocol, :[]
  end

end
