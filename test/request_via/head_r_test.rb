require "test_helper"

class RequestViaHeadRTest < Minitest::Test
  def setup
    use_cases = Support::Assertions::To::Head.(context: self)

    @assert_http = -> { use_cases.('RequestWithReversedMethodVersion') }
  end

  def test_request_with_params
    @assert_http.().(
      protocol_to_request: false,
      params: { number: 1 },
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
      params: { number: 1 },
      headers: { 'X-Requested-With' => 'test' }
    )
  end
end
