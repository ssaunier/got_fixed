# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'got_fixed/version'

Gem::Specification.new do |spec|
  spec.name          = "got_fixed"
  spec.version       = GotFixed::VERSION
  spec.authors       = ["Sebastien Saunier"]
  spec.email         = ["seb@saunier.me"]
  spec.description   = %q{Build a public dashboard of your private issue tracker}
  spec.summary       = %q{Build a public dashboard of your private issue tracker}
  spec.homepage      = "https://github.com/ssaunier/got_fixed"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "httparty"
end
