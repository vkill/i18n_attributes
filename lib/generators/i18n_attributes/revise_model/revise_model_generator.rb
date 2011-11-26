class I18nAttributes::ReviseModelGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  class_option :orm, :required => false, :default => "active_record"

  include ::VkillGemsMethods::Rails::Generators::Base
  ::ActiveRecord::Base.send :include, ::VkillGemsMethods::ActiveRecord::Base

  include I18nAttributes::GeneratorHelpers

  SUPPORTED_ORMS = %w(active_record)

  def create_model_i18n_file

    orm = options.orm.to_s

    say_error "#{orm} [not found]" unless SUPPORTED_ORMS.include? orm

    ::ActiveRecord::Base.models do |model, columns|
      ::I18nAttributes::Configuration.locales.each do |locale|
        create_file "config/locales/model_#{ locale }/#{ model.name.underscore }.yml",
                generate_yaml_file_data(locale, model.model_name.underscore, model.model_name, columns,
                                           orm, model.i18n_scope)
      end
    end

  end

end

