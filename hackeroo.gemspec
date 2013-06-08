# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
# lib = File.expand_path('./lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hackeroo/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_dependency 'multi_json', '~> 1.0'
  spec.add_dependency 'simple_oauth', '~> 0.2'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ["Reza Jelveh"]
  spec.description = %q{A Ruby interface to the Hackeroo API.}
  spec.email = ['reza.jelveh@gmail.com']
  spec.files = %w(Rakefile hackeroo.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = 'http://github.com/fishman/hackeroo'
  spec.licenses = ['MIT']
  spec.name = 'hackeroo'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.5'
  spec.summary = spec.description
  spec.test_files = Dir.glob("spec/**/*")
  spec.version = Hackeroo::Version
end
