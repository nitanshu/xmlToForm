$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'xml_to_form/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'xml_to_form'
  s.version     = XmlToForm::VERSION
  s.authors     = ['nitanshu verma']
  s.email       = ['nitanshu@headerlabs.com']
  s.homepage    = 'https://github.com/nitanshu/xmlToForm'
  s.summary     = 'It converts a xml file to rails form and you can update it through that form.'
  s.description = 'As it is basically a converter of xml file to rails form it takes help from nokogiri do some hacks of nokogiri and update the xml file and create a updated.xml file'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails'
  s.add_dependency 'activemodel'
  s.add_dependency 'nokogiri'


  s.add_development_dependency 'sqlite3'
end
