require "test_helper"

class RequestViaTraceRTest < Minitest::Test
  def setup
    use_cases = Support::Assertions::To::Trace.(context: self)

    @assert_http = -> { use_cases.('RequestWithReversedMethodVersion') }
  end

  def test_request_with_params
    @assert_http.().(
      protocol_to_request: false,
      params: { number: 51 },
      headers: {}
    )
  end

  def test_request_with_headers
    @assert_http.().(
      protocol_to_request: 'http',
      params: {},
      headers: { 'X-Requested-With' => 'test' }
    )
  end

  def test_request_with_params_and_headers
    @assert_http.().(
      protocol_to_request: 'https',
      params: { number: 42 },
      headers: { 'X-Requested-With' => 'test' }
    )
  end
end
