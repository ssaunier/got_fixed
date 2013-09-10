$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "got_fixed/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "got_fixed"
  s.version     = GotFixed::VERSION
  s.authors       = ["Sebastien Saunier"]
  s.email         = ["seb@saunier.me"]
  s.description   = %q{Build a public dashboard of your private issue tracker}
  s.summary       = %q{Build a public dashboard of your private issue tracker}
  s.homepage      = "https://github.com/ssaunier/got_fixed"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "httparty"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
