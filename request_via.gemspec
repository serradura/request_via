# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "request_via/version"

Gem::Specification.new do |spec|
  spec.name          = "request_via"
  spec.version       = RequestVia::VERSION
  spec.authors       = ["Rodrigo Serradura"]
  spec.email         = ["rodrigo@ysimplicity.com"]

  spec.summary       = %q{The functional HTTP client.}
  spec.description   = %q{A fast and functional (API and paradigm) HTTP client, using only standard library's dependencies. e.g: Net::HTTP, and URI.}
  spec.homepage      = "https://github.com/serradura/request_via"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.2.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 3.1"
end
