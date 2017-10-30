# frozen_string_literal: true

module  Support

  module Routes
    extend self

    HOSTS = {
      example_com: 'example.com',
      www_example_com: 'www.example.com'
    }.freeze

    Http = -> url {
      "http://#{url}"
    }.freeze

    Https = -> url {
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
      when 'http' then Http.(host)
      when 'https' then Https.(host)
      else fail NotImplementedError
      end
    }.freeze

    To = -> (protocol, host) {
      BuildRoute.(self[host], protocol)
    }.curry.freeze

    def [](host)
      HOSTS.fetch(host)
    end
  end

end
