module Support
  module Assertions

    class Base
      def initialize(test_context)
        @test = test_context
      end

      def call(*args)
        fail NotImplementedError
      end
    end

  end
end
