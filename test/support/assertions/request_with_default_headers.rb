# frozen_string_literal: true

module Support
  module Assertions

    class RequestWithDefaultHeaders < Base
      def call(protocol_to_request:)
        setup(protocol_to_request)

        stub_request(@example_com, headers: RequestVia::DEFAULT_HEADERS)

        test.assert Func::IsOK.(@request.(@example_com))
      end

      private

      def setup(protocol_to_request)
        @example_com = Routes::To.(protocol_to_request, :example_com)

        @request = Func::GetRequestViaHTTPMethod.(http_method)
      end
    end

  end
end
