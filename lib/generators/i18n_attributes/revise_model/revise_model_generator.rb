class I18nAttributes::ReviseModelGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  class_option :orm, :required => false, :default => "active_record"

  include I18nAttributes::GeneratorHelpers

  SUPPORTED_ORMS = %w(active_record)

  def create_model_i18n_file

    orm = options.orm.to_s

    say_error "#{orm} [not found]" unless SUPPORTED_ORMS.include? orm

    models do |model|
      I18nAttributes::Configuration.locales.each do |locale|
        create_file "config/locales/model_#{ locale }/#{ model.name.underscore }.yml",
                generate_yaml_file_data(locale, model.model_name.underscore, model.model_name, attributes_hash(model), orm)
      end
    end

  end

  private
    def models(&block)
      Rails.application.eager_load!
      ActiveRecord::Base.descendants.each do |model|
        next unless model.respond_to?(:columns_hash)
        next unless model.table_exists?
        next if model.abstract_class?
        next if model.columns_hash.keys.include?('type') and model.descendants.size > 0
        yield model
      end
    end

    def attributes_hash(model)
      Hash[ model.columns_hash.map { |k,v| [k, k.to_s.humanize] } ]
    end

end

