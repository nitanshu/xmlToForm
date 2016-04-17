class RenameXmlHandlersToXmlToFormXmlHandlers < ActiveRecord::Migration
  def change
    def self.up
      rename_table :xml_handlers, :xml_to_form_xml_handlers
    end
    def self.down
      rename_table :new_table_name, :xml_handlers
    end
  end
end
