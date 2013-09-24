#!/usr/bin/gem build
# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name     = "httparty-cookies"
  spec.version  = "0.1"
  spec.summary  = "What does every party need? Cookies!"

  spec.homepage = "https://github.com/mkroman/httparty-cookies"
  spec.license  = "MIT"
  spec.author   = "Mikkel Kroman"
  spec.email    = "mk@uplink.io"
  spec.files    = Dir['library/**/*.rb']

  spec.add_dependency "httparty"
  spec.add_dependency "cookiejar"
	spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"

  spec.require_path = "library"
  spec.required_ruby_version = ">= 1.9.1"
end
