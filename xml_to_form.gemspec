$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'xml_to_form/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'xml_to_form'
  s.version     = XmlToForm::VERSION
  s.authors     = ['nitanshu verma']
  s.email       = ['nitanshu1991@gmail.com']
  s.homepage    = 'https://github.com/nitanshu/xmlToForm'
  s.summary     = 'It converts a xml file to rails form and you can update it through that form.'
  s.description = 'As it is basically a converter of xml file to rails nested form it takes help from nokogiri do some hacks of nokogiri and update the xml file and create an updated.xml file'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_runtime_dependency 'rails', '~>0'
  s.add_runtime_dependency 'activemodel', '~>0'
  s.add_runtime_dependency 'nokogiri', '~>0'
end
