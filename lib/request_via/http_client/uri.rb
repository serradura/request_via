# encoding: UTF-8
# frozen_string_literal: true

module RequestVia
  module HttpClient

    module URI
      extend self

      def parse!(url)
        if url.start_with?('http://', 'https://')
          ::URI.parse(url)
        elsif /([^:]+)?:?\/\// !~ url
          ::URI.parse("http://#{url}")
        else
          fail ::URI::InvalidURIError, 'URI scheme must be http:// or https://'
        end
      end

      def https?(uri)
        uri.instance_of?(::URI::HTTPS)
      end
    end

  end
end
