class I18nAttributes::ModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :orm, :required => true
  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

  include I18nAttributes::GeneratorHelpers

  def create_model_i18n_file

    orm = options.orm.to_s

    say_error "#{orm} [not found]" unless SUPPORTED_ORMS.include? orm

    I18nAttributes::Configuration.locales.each do |locale|
      create_file "config/locales/model_#{ locale }/#{ file_name }.yml",
                  generate_yaml_file_data(locale, singular_name, human_name, attributes_hash, orm)
    end

  end

  private
    def attributes_hash
      Hash[ attributes.map {|attribute| [attribute.name, attribute.human_name] } ]
    end
end

