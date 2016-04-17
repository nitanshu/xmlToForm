class CreateXmlHandlers < ActiveRecord::Migration
  def change
    create_table :xml_to_form_xml_handlers do |t|
      t.timestamps null: false
    end
  end
end
