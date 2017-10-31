# frozen_string_literal: true

module Support
  module Assertions

    class RequestWithReversedMethodVersion < Base
      def call(protocol_to_request:, params:, headers:)
        setup(protocol_to_request, params, headers)

        @paths.each do |path|
          stub_request("#{@example_com}/#{path}", @stub_data)
        end

        responses = @paths.map { |path| "#{@example_com}/#{path}" }
                         .map(&@request.(params: params, headers: headers))

        test.assert responses.all? { |res| Func::IsOK.(res) }
      end

      private

      def setup(protocol_to_request, params, headers)
        @paths = ('a'..'z').to_a.shuffle[0..1]
        @request = Func::GetReversedHTTPMethodVersion.(http_method)
        @stub_data = Func::MockDataToRequestVia.(http_method).(params, headers)
        @example_com = Routes::To.(protocol_to_request, :example_com)
      end
    end

  end
end
