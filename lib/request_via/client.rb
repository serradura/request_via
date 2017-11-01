# frozen_string_literal: true

module RequestVia

  class Client
    attr_reader :address, :net_http

    BuildURL = Freeze.(-> (address, path) {
      "#{address}#{path.start_with?('/') ? path : "/#{path}"}"
    }.curry)

    BuildAddress = -> (uri, address) {
      has_port = uri.port && address =~ /:\d+/
      Freeze.(%{#{uri.scheme}://#{uri.host}#{":#{uri.port}" if has_port}}.chomp('/'))
    }

    OptionsBuilder = Freeze.(-> net_http {
      -> (options) {
        {
          params: options[:params],
          headers: options[:headers],
          net_http: net_http
        }
      }
    })

    def self.call(address, port: nil, open_timeout: nil, read_timeout: nil)
      self.new(address, port, open_timeout, read_timeout)
    end

    def initialize(address, port, open_timeout, read_timeout)
      uri = Freeze.(Func::ParseURI.(address))

      @address = BuildAddress.(uri, address)
      @build_url = BuildURL.(@address)
      @net_http = NetHTTP.(uri, port, open_timeout, read_timeout)
      @options = OptionsBuilder.(@net_http)
    end

    def get(path = '/', **options)
      fetch(RequestVia::Get, path, options)
    end

    def head(path = '/', **options)
      fetch(RequestVia::Head, path, options)
    end

    def post(path = '/', **options)
      fetch(RequestVia::Post, path, options)
    end

    def put(path = '/', **options)
      fetch(RequestVia::Put, path, options)
    end

    def delete(path = '/', **options)
      fetch(RequestVia::Delete, path, options)
    end

    def options(path = '/', **options)
      fetch(RequestVia::Options, path, options)
    end

    def trace(path = '/', **options)
      fetch(RequestVia::Trace, path, options)
    end

    def patch(path = '/', **options)
      fetch(RequestVia::Patch, path, options)
    end

    private

    def fetch(http_method, path, keyword_args)
      http_method.(@build_url.(path), **@options.(keyword_args))
    end
  end

end
