# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'holidapi/version'

Gem::Specification.new do |spec|
  spec.name          = "holidapi"
  spec.version       = HolidApi::VERSION
  spec.authors       = ["Brian Getting"]
  spec.email         = ["brian@tatem.ae"]
  spec.summary       = %q{A Ruby wrapper for the Holiday API service.}
  spec.description   = %q{A Ruby wrapper for the Holiday API service.}
  spec.homepage      = "http://github.com/tatemae-consultancy/holidapi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'fakeweb', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'timecop', '~> 0.7'
  spec.add_development_dependency 'pry', '~> 0.10.1'

  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'json'
end
