# frozen_string_literal: true

module Support
  module Assertions

    class ResponseAndRequestOption < Base
      def call(protocol_to_request:)
        setup(protocol_to_request)

        test.stub_request http_method, @example_com

        res, req = @request.(@example_com, response_and_request: true)

        test.assert_equal '200', res.code
        test.assert_equal @net_http_request, req.class
      end

      private

      def setup(protocol_to_request)
        @example_com = Routes.example_com(protocol: protocol_to_request)

        @request = RequestVia.const_get(http_method_const_name)

        @net_http_request = Net::HTTP.const_get(http_method_const_name)
      end
    end

  end
end
