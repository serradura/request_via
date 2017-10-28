require "test_helper"

class RequestViaHttpURITest < Minitest::Test
  GENERIC_EXAMPLE = 'www.example.com'
  HTTPS_EXAMPLE = "https://#{GENERIC_EXAMPLE}"
  HTTP_EXAMPLE = "http://#{GENERIC_EXAMPLE}"

  def test_https?
    uri = URI.parse(HTTPS_EXAMPLE)

    assert RequestVia::Http::URI.https?(uri)
  end

  def test_parse
    [
      RequestVia::Http::URI.parse!(GENERIC_EXAMPLE),
      RequestVia::Http::URI.parse!(HTTP_EXAMPLE)
    ].each do |uri|
      assert_equal HTTP_EXAMPLE, uri.to_s
    end

    assert_equal(
      HTTPS_EXAMPLE,
      RequestVia::Http::URI.parse!(HTTPS_EXAMPLE).to_s
    )
  end

  def test_parse_error
    assert_raises URI::InvalidURIError do
      RequestVia::Http::URI.parse!('ftp://test.com')
    end
  end
end
