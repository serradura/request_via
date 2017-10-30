module  Support
  module Routes
    extend self

    EXAMPLE_COM = 'example.com'

    WWW_EXAMPLE_COM = "www.#{EXAMPLE_COM}"

    Http = -> url { "http://#{url}" }

    Https = -> url { "https://#{url}" }

    BuildRoute = -> (host, protocol) {
      case String(protocol).downcase
      when 'false' then host
      when 'https' then Https.(host)
      when 'http' then Http.(host)
      else fail NotImplementedError
      end
    }

    def example_com(protocol: false)
      BuildRoute.(EXAMPLE_COM, protocol)
    end

    def www_example_com(protocol: false)
      BuildRoute.(WWW_EXAMPLE_COM, protocol)
    end
  end
end
