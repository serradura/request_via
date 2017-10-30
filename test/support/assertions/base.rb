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

      def http_method_const_name
        String(http_method).capitalize
      end
    end

  end
end
