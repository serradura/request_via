require "test_helper"

class RequestViaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RequestVia::VERSION
  end

  def test_url_parse_error
    assert_raises URI::InvalidURIError do
      RequestVia::Get.('ftp://example.com')
    end

    assert_raises URI::InvalidURIError do
      RequestVia::Post.('://example.com')
    end

    assert_raises URI::InvalidURIError do
      RequestVia::Put.('//example.com')
    end

    assert_raises URI::InvalidURIError do
      RequestVia::Delete.('tcp://example.com')
    end
  end
end
