#encoding: utf-8

class I18nAttributes::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_initializer_file
    template "i18n_attributes.rb", 'config/initializers/i18n_attributes.rb'
  end

  def modify_application_config
    inject_into_file 'config/application.rb', :after => /< Rails::Application[\s]*$/ do
      %Q|
    config.i18n.load_path += Dir[%Q`\#{config.root}/config/locales/**/*.{rb,yml}`]
|
    end
  end

end

