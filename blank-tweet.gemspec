# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blank/tweet/version'

Gem::Specification.new do |spec|
  spec.name          = "blank-tweet"
  spec.version       = Blank::Tweet::VERSION
  spec.authors       = ["youpy"]
  spec.email         = ["youpy@buycheapviagraonlinenow.com"]
  spec.summary       = 'A web app for tweeting blank tweets'
  spec.description   = 'A web app for tweeting blank tweets'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "oauth"
  spec.add_dependency "twitter", "~> 5.13.0"
  spec.add_dependency "string-pad"

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0"
end
