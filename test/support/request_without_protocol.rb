module Support

  class RequestWithoutProtocol
    def initialize(test_context)
      @test = test_context
    end

    def call(http_verb, protocol_to_request:)
      @test.stub_request http_verb, Routes.example_com(protocol: protocol_to_request)
      @test.stub_request http_verb, Routes.www_example_com(protocol: protocol_to_request)

      request = RequestVia.const_get String(http_verb).capitalize

      res1 = request.(Routes::EXAMPLE_COM)
      res2 = request.(Routes::WWW_EXAMPLE_COM)

      @test.assert_equal '200', res1.code
      @test.assert_equal '200', res2.code
    end
  end

end
