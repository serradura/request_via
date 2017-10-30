# frozen_string_literal: true

module Support
  module Assertions

    class Base
      attr_reader :http_method, :test

      def initialize(test_context, http_method:)
        @test = test_context
        @http_method = http_method
      end

      def call(*args)
        fail NotImplementedError
      end

      private

      def stub_request(url, mock_data = {})
        test.stub_request(http_method, url).tap do |request|
          request.with(mock_data) unless mock_data.empty?
        end
      end
    end

  end
end
