module Support
  module Assertions

    class ResponseAndRequestOption < Base
      def call(http_verb, protocol_to_request:)
        setup(http_verb, protocol_to_request)

        @test.stub_request http_verb, @example_com

        res, req = @request.(@example_com, response_and_request: true)

        @test.assert_equal '200', res.code
        @test.assert_equal @net_http_request, req.class
      end

      private

      def setup(http_verb, protocol_to_request)
        http_verb_class_name = String(http_verb).capitalize

        @example_com = Routes.example_com(protocol: protocol_to_request)

        @request = RequestVia.const_get(http_verb_class_name)

        @net_http_request = Net::HTTP.const_get(http_verb_class_name)
      end
    end

  end
end
