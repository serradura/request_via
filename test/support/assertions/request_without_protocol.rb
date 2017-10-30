module Support
  module Assertions

    class RequestWithoutProtocol < Base
      def call(http_verb, protocol_to_request:)
        setup(http_verb, protocol_to_request)

        @test.stub_request http_verb, @example_com
        @test.stub_request http_verb, @www_example_com

        @test.assert_equal '200', @request.(Routes::EXAMPLE_COM).code
        @test.assert_equal '200', @request.(Routes::WWW_EXAMPLE_COM).code
      end

      private

      def setup(http_verb, protocol_to_request)
        @example_com = Routes.example_com(protocol: protocol_to_request)

        @www_example_com = Routes.www_example_com(protocol: protocol_to_request)

        @request = RequestVia.const_get String(http_verb).capitalize
      end
    end

  end
end
