#encoding: utf-8

class I18nAttributes::ReviseModelGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  class_option :orm, :required => false, :default => "active_record"

  include ::VkillGemsMethods::Rails::Generators::Base
  ::ActiveRecord::Base.send :include, ::VkillGemsMethods::ActiveRecord::Base

  include ::I18nAttributes::GeneratorHelpers

  SUPPORTED_ORMS = %w(active_model active_record mongoid)

  def create_model_i18n_file

    say_error "#{orm} [not found]" unless SUPPORTED_ORMS.include? options.orm.to_s

    ::ActiveRecord::Base.models do |model, columns|
      ::I18nAttributes::Configuration.locales.each do |locale|
        create_file "config/locales/model_#{ locale }/#{ model.name.underscore }.yml",
                generate_yaml_file_data(
                  :locale => locale,
                  :singular_name => model.model_name.underscore,
                  :human_name => model.model_name,
                  :attributes => columns,
                  :model_i18n_scope => model.i18n_scope
                ){|word| say_info "translated attribute/model_name #{word}"}.yaml_file_data
      end
    end

  end

end

