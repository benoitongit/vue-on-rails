# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vue_on_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "vue_on_rails"
  spec.version       = VueOnRails::VERSION
  spec.authors       = ["Benoit Zeler"]
  spec.email         = "benoit@kimkim.com"

  spec.summary       = %q{Easy and simple way to use Vue.js with Ruby on Rails and Turbolinks 5.}
  spec.description   = %q{Ideal to sprinkle your app with Vue components}
  spec.homepage      = "https://github.com/benoitongit"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = Dir["{lib,vendor}/**/*", "LICENSE.txt", "README.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "coffee-rails", ">= 4.0", "< 5.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", ">= 4.0", "<= 5.2"
end
