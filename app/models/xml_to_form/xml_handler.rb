require 'noko_hacks'
module XmlToForm
  class XmlHandler < ActiveRecord::Base
    include ActiveModel::Model
    extend NokoHacks
    extend ActiveModel::Callbacks

    def after_initialize(some_hash)
      some_hash.each do |key, value|
        self.send("#{key}=", value) rescue nil
      end if some_hash.is_a?(Hash)
    end

    def self.noko_meta_data(file)
      xml_obj = Nokogiri::XML(file).remove_namespaces! do |config|
        config.default_xml.noblanks
      end
      xml_obj.children.remove_blank_node
      xml_obj.children.iterate_child_nodes(_node_array= [], attr_accessor_hash ={})
      attr_accessor_hash.each do |attr_key, attr_value|
        attr_accessor attr_key.to_sym
      end
      return _node_array, attr_accessor_hash, xml_obj
    end
  end
end
