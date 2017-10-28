require "test_helper"

class RequestViaHttpClientURITest < Minitest::Test
  GENERIC_EXAMPLE = 'www.example.com'
  HTTPS_EXAMPLE = "https://#{GENERIC_EXAMPLE}"
  HTTP_EXAMPLE = "http://#{GENERIC_EXAMPLE}"

  def test_https?
    uri = URI.parse(HTTPS_EXAMPLE)

    assert RequestVia::HttpClient::URI.https?(uri)
  end

  def test_parse
    [
      RequestVia::HttpClient::URI.parse!(GENERIC_EXAMPLE),
      RequestVia::HttpClient::URI.parse!(HTTP_EXAMPLE)
    ].each do |uri|
      assert_equal HTTP_EXAMPLE, uri.to_s
    end

    assert_equal(
      HTTPS_EXAMPLE,
      RequestVia::HttpClient::URI.parse!(HTTPS_EXAMPLE).to_s
    )
  end

  def test_parse_error
    assert_raises URI::InvalidURIError do
      RequestVia::HttpClient::URI.parse!('ftp://test.com')
    end
  end
end
