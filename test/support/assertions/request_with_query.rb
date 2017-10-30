# frozen_string_literal: true

module Support
  module Assertions

    class RequestWithQuery < Base
      def call(protocol_to_request:, params:, headers:)
        setup(protocol_to_request)

        stub_request(@example_com, params, headers)
        stub_request(@www_example_com, params, headers)

        response = @request.(@example_com, params: params, headers: headers)
        www_response = @request.(@www_example_com, params: params, headers: headers)

        test.assert_equal '200', response.code
        test.assert_equal '200', www_response.code
      end

      private

      def setup(protocol_to_request)
        @example_com = Routes.example_com(protocol: protocol_to_request)

        @www_example_com = Routes.www_example_com(protocol: protocol_to_request)

        @request = RequestVia.const_get http_method_const_name
      end

      def stub_request(url, params, headers)
        stub_query = stringify_hash_kv(params)
        stub_headers = stringify_hash_kv(headers)

        stub_data = {}
        stub_data[:query] = stub_query unless stub_query.empty?
        stub_data[:headers] = stub_headers unless stub_headers.empty?

        test.stub_request(http_method, url).tap do |request|
          request.with(stub_data) unless stub_data.empty?
        end
      end

      def stringify_hash_kv(hash)
        return hash if hash.empty?

        hash.reduce({}) do |memo, (key, value)|
          memo.update String(key) => String(value)
        end
      end
    end

  end
end
