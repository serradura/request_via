require "test_helper"

class RequestViaClientTest < Minitest::Test
  def setup
    stub_request(:any, '127.0.0.1:3000').with(query: { 'c' => '3' })
    stub_request(:any, 'http://example.io')
    stub_request(:any, 'http://example.io').with(query: { 'a' => '1' }, headers: { 'Foo' => 'foo' })
    stub_request(:any, 'http://example.io/foo')
    stub_request(:any, 'https://example.com/foo/bar')
    stub_request(:any, 'https://example.com/foo/bar').with(body: { 'b' => '2'}, headers: { 'Bar' => 'bar' })

    @client1 = RequestVia::Client.('example.io/')
    @client2 = RequestVia::Client.('http://example.io/foo/')
    @client3 = RequestVia::Client.('https://example.com/foo/bar/')
    @client4 = RequestVia::Client.('127.0.0.1', port: 3000)
  end

  def test_default_headers
    @client0 = RequestVia::Client.('example.com.br')

    stub_request(:get, 'http://example.com.br').with(headers: RequestVia::DEFAULT_HEADERS)

    assert Support::Func::IsOK.(@client0.get)
  end

  def test_get_request
    assert Support::Func::IsOK.(@client1.get)
    assert Support::Func::IsOK.(@client1.get(params: { a: 1 }, headers: { foo: :foo }))
    assert Support::Func::IsOK.(@client1.get('/'))
    assert Support::Func::IsOK.(@client2.get('foo'))
    assert Support::Func::IsOK.(@client2.get('/foo'))
    assert Support::Func::IsOK.(@client3.get('foo/bar'))
    assert Support::Func::IsOK.(@client3.get('/foo/bar'))
    assert Support::Func::IsOK.(@client4.get(params: { c: 3 }))
  end

  def test_head_request
    assert Support::Func::IsOK.(@client1.head)
    assert Support::Func::IsOK.(@client1.head('/', params: { a: 1 }, headers: { foo: :foo }))
    assert Support::Func::IsOK.(@client2.head('foo'))
    assert Support::Func::IsOK.(@client2.head('/foo'))
    assert Support::Func::IsOK.(@client3.head('foo/bar'))
    assert Support::Func::IsOK.(@client3.head('/foo/bar'))
  end

  def test_post_request
    assert Support::Func::IsOK.(@client1.post)
    assert Support::Func::IsOK.(@client1.post('/'))
    assert Support::Func::IsOK.(@client2.post('foo'))
    assert Support::Func::IsOK.(@client2.post('/foo'))
    assert Support::Func::IsOK.(@client3.post('foo/bar', params: { b: 2 }, headers: { bar: :bar }))
    assert Support::Func::IsOK.(@client3.post('/foo/bar'))
  end

  def test_put_request
    assert Support::Func::IsOK.(@client1.put)
    assert Support::Func::IsOK.(@client1.put('/'))
    assert Support::Func::IsOK.(@client2.put('foo'))
    assert Support::Func::IsOK.(@client2.put('/foo'))
    assert Support::Func::IsOK.(@client3.put('foo/bar'))
    assert Support::Func::IsOK.(@client3.put('/foo/bar', params: { b: 2 }))
  end

  def test_delete_request
    assert Support::Func::IsOK.(@client1.delete(headers: { foo: :foo }))
    assert Support::Func::IsOK.(@client1.delete('/'))
    assert Support::Func::IsOK.(@client2.delete('foo'))
    assert Support::Func::IsOK.(@client2.delete('/foo'))
    assert Support::Func::IsOK.(@client3.delete('foo/bar'))
    assert Support::Func::IsOK.(@client3.delete('/foo/bar'))
  end

  def test_options_request
    assert Support::Func::IsOK.(@client1.options(params: { a: 1 }, headers: { foo: :foo }))
    assert Support::Func::IsOK.(@client1.options('/'))
    assert Support::Func::IsOK.(@client2.options('foo'))
    assert Support::Func::IsOK.(@client2.options('/foo'))
    assert Support::Func::IsOK.(@client3.options('foo/bar'))
    assert Support::Func::IsOK.(@client3.options('/foo/bar'))
  end

  def test_trace_request
    assert Support::Func::IsOK.(@client1.trace)
    assert Support::Func::IsOK.(@client1.trace('/', params: { a: 1 }, headers: { foo: :foo }))
    assert Support::Func::IsOK.(@client2.trace('foo'))
    assert Support::Func::IsOK.(@client2.trace('/foo'))
    assert Support::Func::IsOK.(@client3.trace('foo/bar'))
    assert Support::Func::IsOK.(@client3.trace('/foo/bar'))
  end

  def test_patch_request
    assert Support::Func::IsOK.(@client1.patch)
    assert Support::Func::IsOK.(@client1.patch('/'))
    assert Support::Func::IsOK.(@client2.patch('foo'))
    assert Support::Func::IsOK.(@client2.patch('/foo'))
    assert Support::Func::IsOK.(@client3.patch('foo/bar'))
    assert Support::Func::IsOK.(@client3.patch('/foo/bar', headers: { bar: :bar }))
  end
end
