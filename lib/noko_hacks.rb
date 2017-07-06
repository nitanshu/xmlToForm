module NokoHacks
  extend ActiveSupport::Concern
  Nokogiri::XML::NodeSet.send :include, NokoHacks
  Nokogiri::XML::Text.send :include, NokoHacks
  Nokogiri::XML::Element.send :include, NokoHacks

  def remove_blank_node
    self.children.each do |node|
      if node.blank?
        node.remove
      end
      if node.children
        node.remove_blank_node
      end
    end
  end

  def update_xml_attributes(node, key, value)
    node.attributes.each do |k, v|
      if k == get_node_attribute_name(key)
        v.value = value
      end
    end
  end

  def update_xml(node, key, value)
    case [node.content.empty?, node.attributes.empty?]
      when [false, true] then node.content = value

      when [false, false] then node.content = value && update_xml_attributes(node, key, value)

      when [true, false] then update_xml_attributes(node, key, value)
    end
  end

  def decode_node_path(node)
    Base64.decode64(node.split('_').last)
  end

  def get_node_attribute_name(key)
    (_split_key = key.split('_')).size > 2 ? _split_key.take(_split_key.size - 1).join('-').sub('@','') : _split_key.first.sub('@','')
  end

  def iterate_child_nodes(node_array, attr_accessor_hash)
    self.children.each do |node|
      build_ds(node, node_array, attr_accessor_hash)
    end
  end

  def encode_node_path(node)
    ('_' + Base64.urlsafe_encode64((Nokogiri::CSS.xpath_for node.css_path).first)).gsub('=','')
  end

  def build_ds(node, node_array,  attr_accessor_hash)
    case [node.attributes.empty? , node.content.empty? ,node.children.empty?]

      when [false, true, true] then node_array.push({(node.name + encode_node_path(node)).gsub('-','_') => node.attributes.transform_keys{|key| (key + encode_node_path(node)).gsub('-','_')} }) && node.attributes.each {|key,value|
        attr_accessor_hash.merge!((key + encode_node_path(node)).gsub('-','_') => value.value)}

      when [true, false, false] then node_array.push({(node.name + encode_node_path(node)).gsub('-','_') => node.content, :child_node => node.child_node_ds(attr_accessor_hash) }) && attr_accessor_hash.merge!((node.name + encode_node_path(node)).gsub('-','_') => node.content)

      when [false, true, false] then node_array.push({(node.name + encode_node_path(node)).gsub('-','_')=> node.attributes.transform_keys{|key| (key + encode_node_path(node)).gsub('-','_')}, :child_node => node.child_node_ds(attr_accessor_hash) }) && node.attributes.each {|key,value| attr_accessor_hash.merge!((key + encode_node_path(node)).gsub('-','_') => value.value)}

      when [false, false, false] then node_array.push({(node.name + encode_node_path(node)).gsub('-','_') => (node.attributes.transform_keys{|key| (key + encode_node_path(node)).gsub('-','_')}).merge!((node.name + encode_node_path(node)).gsub('-','_') => node.content) }) && node.attributes.each {|key,value| attr_accessor_hash.merge!((key + encode_node_path(node)).gsub('-','_') => value.value)} && attr_accessor_hash.merge!((node.name + encode_node_path(node)).gsub('-','_') => node.content)
    end
  end

  def child_node_ds(attr_accessor_hash)
    _temp=[]
    self.children.each do |node|
      case [node.attributes.empty? , node.content.empty? ,node.children.empty?]

        when [false, true, true] then  _temp.push({(node.name + encode_node_path(node)).gsub('-','_') => node.attributes.transform_keys{|key| (key + encode_node_path(node)).gsub('-','_')}}) && node.attributes.each {|key,value| attr_accessor_hash.merge!((key + encode_node_path(node)).gsub('-','_') => value.value)}

        when [true, false, false] then  _temp.push({(node.parent.name + encode_node_path(node)).gsub('-','_') => node.content, :child_node => node.child_node_ds(attr_accessor_hash) }) && attr_accessor_hash.merge!((node.parent.name + encode_node_path(node)).gsub('-','_') => node.content)

        when [false, true, false] then   _temp.push({(node.name + encode_node_path(node)).gsub('-','_')  => node.attributes.transform_keys{|key| (key + encode_node_path(node)).gsub('-','_')}, :child_node => node.child_node_ds(attr_accessor_hash)})&& node.attributes.each {|key,value| attr_accessor_hash.merge!((key + encode_node_path(node)).gsub('-','_') => value.value)}

        when [false, false, false] then _temp.push({(node.name + encode_node_path(node)).gsub('-','_') => (node.attributes.transform_keys{|key| (key + encode_node_path(node)).gsub('-','_')}).merge!((node.name + encode_node_path(node)).gsub('-','_') => node.content)}) && node.attributes.each {|key,value| attr_accessor_hash.merge!((key + encode_node_path(node)).gsub('-','_') => value.value)} && attr_accessor_hash.merge!((node.name + encode_node_path(node)).gsub('-','_') => node.content)
      end
    end
    return _temp
  end
end

