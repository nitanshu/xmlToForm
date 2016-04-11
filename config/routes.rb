XmlToForm::Engine.routes.draw do
  post 'xml_form', to: 'xml_handlers#xml_form'
  post 'xml_update',to: 'xml_handlers#xml_update'
  get 'upload_file', to: 'xml_handlers#upload_file'
  root to: 'xml_handlers#upload_file'
end
