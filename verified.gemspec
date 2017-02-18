$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "verified/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "verified"
  s.version     = Verified::VERSION
  s.authors       = ["Jackson Oates"]
  s.email         = ["jackson.oates@gmail.com"]
  s.description   = %q{Provide a clean interface for working with background check service}
  s.summary       = %q{interface with background check service}
  s.homepage      = "https://github.com/allibubba/verifed"
  s.license       = "MIT"
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "sqlite3"
end
