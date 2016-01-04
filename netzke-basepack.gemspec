require "./lib/netzke/basepack/version"

Gem::Specification.new do |s|
  s.name        = "netzke-basepack"
  s.version     = Netzke::Basepack::VERSION
  s.author      = "Max Gorin"
  s.email       = "max@goodbitlabs.com"
  s.homepage    = "http://netzke.org"
  s.summary     = "Pre-built Netzke components"
  s.description = "A set of feature-rich extendible Netzke components (such as Grid, Tree, Form, Window) and component extensions which can be used as building blocks for your apps"

  s.files         = Dir["{javascripts,lib,locales,stylesheets}/**/*", "[A-Z]*", "init.rb"] - ["Gemfile.lock", "spec/rails_app/public/extjs"]
  s.test_files    = Dir["{test}/**/*"]
  s.require_paths = ["lib"]

  s.required_rubygems_version = ">= 1.3.4"
end
