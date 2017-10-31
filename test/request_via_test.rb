require "test_helper"

class RequestViaTest < Minitest::Test
  BuildNetHTTPMock = -> {
    mock = Minitest::Mock.new
    mock.expect(:instance_of?, true, [Net::HTTP])
    mock.expect(:request, Object.new, [Net::HTTP::Get])
    mock
  }

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
  end

  def test_port_option
    net_http = BuildNetHTTPMock.()

    constructor = -> (host, port) {
      assert_equal 'example.io', host
      assert_equal 2000, port
      net_http
    }

    Net::HTTP.stub :new, constructor do
      RequestVia::Get.('http://example.io', port: 2000)
    end

    assert net_http.verify
  end

  def test_timeout_options
    net_http = BuildNetHTTPMock.()
    net_http.expect(:open_timeout=, nil, [200])
    net_http.expect(:read_timeout=, nil, [120])

    Net::HTTP.stub :new, net_http do
      RequestVia::Get.('http://bar.com', read_timeout: 120, open_timeout: 200)
    end

    assert net_http.verify
  end

  def test_net_http_option
    net_http = BuildNetHTTPMock.()
    net_http_option = -> (host, port) { net_http }

    Net::HTTP.stub :new, net_http do
      RequestVia::Get.('http://foo.com', net_http: net_http_option )
    end

    assert net_http.verify
  end

  def test_net_http_option_error
    net_http_option = -> (host, port) { 'Is not a Net::HTTP object' }

    assert_raises TypeError do
      RequestVia::Get.('http://foo.com', net_http: net_http_option )
    end
  end
end
