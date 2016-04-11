module XmlToForm
  module XmlHandlersHelper
    def iterate_node(node, f)
      render partial: 'xml_to_form/xml_handlers/parent_node_form', locals: {node_hash: node, f: f}
    end
  end
end
