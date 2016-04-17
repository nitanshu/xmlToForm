require_dependency "xml_to_form/application_controller"
require 'noko_hacks'
require_dependency 'xml_to_form/xml_handler.rb'

module XmlToForm
  class XmlHandlersController < ApplicationController
    include NokoHacks
    before_filter :fetch_data, except:  [:upload_file]

## @node_set is an array of each node with child and attributes which is representing the form in recursive way
## @attr_accessors is an hash where key is xml tag and their Base64 encoded path and value is there values
## @xml_obj is only the parsed object of nokogiri from xml
## @xml_data is the initialized object with their values which represents the form
    def upload_file

    end

    def xml_form
      # logger.info "============#{@attr_accessors.inspect}"
      @xml_data = XmlHandler.new(@attr_accessors)
      # logger.info "=====---------#{@xml_data.inspect}"
    end

    def xml_update
      @xml = XmlHandler.new(params[:xml_data])
      params[:xml_handler].each do |key,value|
        node = @xml_obj.at(decode_node_path(key))
        update_xml(node, key, value)
        if !node.content.empty? && !node.attributes.empty?
          node.content = value
        end
      end
      File.open('updated.xml', 'w') {|f| f.write(@xml_obj)}
      redirect_to root_path
    end

    private
    def fetch_data
      params[:file]? @file= File.read(params[:file].tempfile) : @file = params[:file_content]
      @node_set, @attr_accessors , @xml_obj= XmlHandler.noko_meta_data(@file)
    end
  end
end
