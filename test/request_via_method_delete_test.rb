require "test_helper"

class RequestViaMethodDeleteTest < Minitest::Test
  def test_request_without_protocol
    assert_http = Support::Assertions::RequestWithoutProtocol.new(self, http_method: :delete)
    assert_http.(protocol_to_request: 'http')
  end

  def test_response_and_request_option
    assert_http = Support::Assertions::ResponseAndRequestOption.new(self, http_method: :delete)
    assert_http.(protocol_to_request: false)
    assert_http.(protocol_to_request: 'http')
    assert_http.(protocol_to_request: 'https')
  end

  def test_request_without_params
    assert_http = Support::Assertions::RequestWithQuery.new(self, http_method: :delete)
    assert_http.(protocol_to_request: false, params: {}, headers: {})
    assert_http.(protocol_to_request: 'http', params: {}, headers: {})
    assert_http.(protocol_to_request: 'https', params: {}, headers: {})
  end

  def test_request_with_params
    assert_http = Support::Assertions::RequestWithQuery.new(self, http_method: :delete)
    assert_http.(protocol_to_request: false, params: {'a' => '1'}, headers: {})
    assert_http.(protocol_to_request: 'http', params: {b: '2'}, headers: {})
    assert_http.(protocol_to_request: 'https', params: {c: 3}, headers: {})
  end

  def test_request_with_headers
    assert_http = Support::Assertions::RequestWithQuery.new(self, http_method: :delete)
    assert_http.(protocol_to_request: false, params: {}, headers: {'Accept' => 'image/png' })
    assert_http.(protocol_to_request: 'http', params: {}, headers: {'Accept' => 'image/jpg' })
    assert_http.(protocol_to_request: 'https', params: {}, headers: {'Accept' => 'image/gif' })
  end

  def test_request_with_headers_and_params
    assert_http = Support::Assertions::RequestWithQuery.new(self, http_method: :delete)
    assert_http.(protocol_to_request: false, params: {c: 3}, headers: {'Accept' => 'image/png' })
    assert_http.(protocol_to_request: 'http', params: {b: '2'}, headers: {'Accept' => 'image/jpg' })
    assert_http.(protocol_to_request: 'https', params: {'a' => '1'}, headers: {'Accept' => 'image/gif' })
  end
end
