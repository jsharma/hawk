$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hawk/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hawk"
  s.version     = Hawk::VERSION
  s.authors     = ["STPL"]
  s.email       = ["jayesh@systematixtechnocrates.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Hawk."
  s.description = "TODO: Description of Hawk."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  # s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "jquery-rails"

  # s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  # s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency "shoulda-matchers", "~>1.0"
end
