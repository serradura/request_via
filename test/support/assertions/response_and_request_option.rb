# frozen_string_literal: true

module Support
  module Assertions

    class ResponseAndRequestOption < Base
      def call(protocol_to_request:)
        setup(protocol_to_request)

        stub_request(@example_com)

        res, req = @request.(@example_com, response_and_request: true)

        test.assert Func::IsOK.(res)
        test.assert_equal @net_http_request, req.class
      end

      private

      def setup(protocol_to_request)
        @request = Func::GetRequestViaHTTPMethod.(http_method)
        @example_com = Routes::To.(protocol_to_request, :example_com)
        @net_http_request = Func::HTTPMethodConstOf.(Net::HTTP, http_method)
      end
    end

  end
end
