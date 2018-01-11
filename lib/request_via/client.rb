# frozen_string_literal: true

module RequestVia

  class Client
    attr_accessor :address
    attr_reader :net_http, :map

    Map = -> (client, path) {
      client.clone.tap { |c| c.address = BuildURL.(c.address, path) }
    }.curry

    ROOT_PATH = Freeze.('/')

    BuildURL = -> (address, path) {
      "#{address}#{path.start_with?(ROOT_PATH) ? path : "/#{path}"}"
    }.curry

    BuildAddress = -> (uri, address) {
      has_port = uri.port && address =~ /:\d+/
      Freeze.(%{#{uri.scheme}://#{uri.host}#{":#{uri.port}" if has_port}}.chomp('/'))
    }

    OptionsBuilder = -> net_http {
      -> (options) {
        {
          params: options[:params],
          headers: options[:headers],
          net_http: net_http
        }
      }
    }

    ResolveArgsToFetch = -> ((left, right)) {
      case left
      when nil then [ROOT_PATH, {}]
      when Hash then [ROOT_PATH, left]
      else [String(left), Hash(right)]
      end
    }

    def self.call(address, port: nil, open_timeout: nil, read_timeout: nil)
      self.new(address, port, open_timeout, read_timeout)
    end

    def initialize(address, port, open_timeout, read_timeout)
      uri = Freeze.(Func::ParseURI.(address))

      @address = BuildAddress.(uri, address)
      @url_with = BuildURL.(@address)
      @net_http = NetHTTP.(uri, port, open_timeout, read_timeout)
      @options = OptionsBuilder.(@net_http)
      @map = Map.(self)
    end

    def get(*args)
      fetch(RequestVia::Get, args)
    end

    def head(*args)
      fetch(RequestVia::Head, args)
    end

    def post(*args)
      fetch(RequestVia::Post, args)
    end

    def put(*args)
      fetch(RequestVia::Put, args)
    end

    def delete(*args)
      fetch(RequestVia::Delete, args)
    end

    def options(*args)
      fetch(RequestVia::Options, args)
    end

    def trace(*args)
      fetch(RequestVia::Trace, args)
    end

    def patch(*args)
      fetch(RequestVia::Patch, args)
    end

    private

    def fetch(http_method, args)
      path, keyword_args = ResolveArgsToFetch.(args)

      options = @options.(keyword_args)

      http_method.(@url_with.(path), **options)
    end
  end

end
