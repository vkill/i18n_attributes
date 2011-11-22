class I18nAttributes::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_initializer_file
    initializer 'i18n_attributes.rb' do
      %Q/
if Rails.env.development?
  I18nAttributes.configure do |config|
    #more > I18n.available_locales
    config.locales = [:en, :"zh-CN"]
    config.enums_attributes = {
      "gender" => {"male" => "Male", "female" => "Female"},
      "state" => {"pending" => "Pending", "processing" => "Processing", "processed" => "Processed"},
      "category" => {"a" => "A", "b" => "B"}
    }
  end
end
/
    end
  end

  def modify_application_config
    inject_into_file 'config/application.rb', :after => /< Rails::Application[\s]*$/ do
      %Q|
    config.i18n.load_path += Dir[%Q`\#{config.root}/config/locales/**/*.{rb,yml}`]
|
    end
  end

end

