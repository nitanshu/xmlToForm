$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "xml_to_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "xml_to_form"
  s.version     = XmlToForm::VERSION
  s.authors     = ["nitanshu verma"]
  s.email       = ["nitanshu@headerlabs.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of XmlToForm."
  s.description = "TODO: Description of XmlToForm."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency 'activemodel'
  s.add_dependency 'nokogiri'


  s.add_development_dependency "sqlite3"
end
