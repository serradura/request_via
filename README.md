# RequestVia

A fast and functional (API and paradigm) HTTP client, using only Ruby's standard library as dependency. e.g: Net::HTTP and URI.

![gif](http://g.recordit.co/S6EPTX5hHH.gif)

List of all commands shown in the GIF:
```ruby
require 'request_via'

# Thanks to @ElliottLandsborough Dog CEO API (https://github.com/ElliottLandsborough/dog-ceo-api)

# --- Single request

response = RequestVia::Get.('https://dog.ceo/api/breed/boxer/images/random')
response.body

# --- Make requests over a map iteration

dogs = [ 'akita', 'chihuahua', 'beagle' ]
dog_images = dogs.map { |breed_name| "https://dog.ceo/api/breed/#{breed_name}/images/random" }
dog_images.map(&RequestVia::Get).map(&:body)

# If do you want to pass common arguments for each request use the GetR function (R = reversed arguments)
# Available options: port, params, headers, open_timeout read_timeout, response_and_request, net_http
dog_images.map(&RequestVia::GetR.(open_timeout: 10)).map(&:body)

# --- Make requests over an ASYNC map iteration

require 'parallel' # https://rubygems.org/gems/parallel

Parallel.map(dog_images, &RequestVia::Get).map(&:body)

# Apply common options for each request
Parallel.map(dog_images, &RequestVia::GetR.(open_timeout: 10)).map(&:body)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'request_via'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install request_via

## Usage

Making a HTTP GET request
```ruby
# Use http:// as the protocol when there is no one defined.
RequestVia::Get.call('example.com')

RequestVia::Get.call('http://example.com')

# We recommend to use the `.()` syntax to invoke/make the HTTP requests.
# Read more about this: https://ruby-doc.org/core-2.2.2/Proc.html#method-i-call
RequestVia::Get.('example.com')

# Request with params
RequestVia::Get.('example.com', params: { foo: 'bar' })

# Request with headers
RequestVia::Get.('example.com/foo', headers: { 'X-Requested-With': 'RequestVia gem' })

# Return the response and request objects
response, request = RequestVia::Get.('example.com/foo', response_and_request: true)

# Request with the reversed arguments order
%w[
  example.com/foo example.com/bar
].map &RequestVia::GetR.(headers: { 'X-Requested-With': 'RequestVia gem' })

# Other options
RequestVia::Get.('example.io', port: 2000,
                               open_timeout: 10,  # Default: 60
                               read_timeout: 120, # Default: 60
                               net_http: -> (host, port) {
                                   net_http = Net::HTTP.new(host, port)
                                   # Make your customizations
                                   net_http
                               })
```

Supported HTTP methods.
(**NOTE:** you can use all arguments of previous examples)
```ruby
RequestVia::Head.()    # RequestVia::HeadR.()

RequestVia::Post.()    # RequestVia::PostR.()

RequestVia::Put.()     # RequestVia::PutR.()

RequestVia::Delete.()  # RequestVia::DeleteR.()

RequestVia::Options.() # RequestVia::OptionsR.()

RequestVia::Trace.()   # RequestVia::TraceR.()

RequestVia::Patch.()   # RequestVia::PatchR.()
```

Making a HTTPS request.
```ruby
RequestVia::Get.('https://example.com')
```

Create a HTTP(S) client for REST resources.
```ruby
client = RequestVia::Client.('https://example.com')

client.get # same of client.get('/')

# Supported arguments: params:, headers:
client.get(params: { a: 1 }, headers: { 'Header-Name' => 'Header-Value' })

client.get('foo', params: { a: 1 })

client.get('/bar', headers: { 'User-Agent' => 'REST Example' })

# Supported HTTP methods:
# client.get
# client.head
# client.post
# client.put
# client.delete
# client.options
# client.trace
# client.patch

# Supported options
RequestVia::Client.('example.com/foo/bar', port: 3000,
                                           open_timeout: 10,
                                           read_timeout: 100)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/request_via. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RequestVia project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/request_via/blob/master/CODE_OF_CONDUCT.md).
