# frozen_string_literal: true

module Support
  module Assertions

    class RequestWithQuery < Base
      def call(protocol_to_request:, params:, headers:)
        setup(protocol_to_request, params, headers)

        stub_request(@example_com, @stub_data)
        stub_request(@www_example_com, @stub_data)

        response = @request.(@example_com, params: params, headers: headers)
        www_response = @request.(@www_example_com, params: params, headers: headers)

        test.assert Func::IsOK.(response)
        test.assert Func::IsOK.(www_response)
      end

      private

      def setup(protocol_to_request, params, headers)
        routes = Routes::To.(protocol_to_request)

        @request = Func::GetRequestViaHTTPMethod.(http_method)
        @stub_data = Func::MockDataToRequestWithQuery.(params, headers)
        @example_com = routes.(:example_com)
        @www_example_com = routes.(:www_example_com)
      end
    end

  end
end
