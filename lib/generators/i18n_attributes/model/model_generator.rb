class I18nAttributes::ModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :orm, :required => true
  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

  include I18nAttributes::GeneratorHelpers

  SUPPORTED_ORMS = %w(active_model active_record mongoid)

  def create_model_i18n_file

    say_error "#{orm} [not found]" unless SUPPORTED_ORMS.include? options.orm.to_s

    I18nAttributes::Configuration.locales.each do |locale|
      create_file "config/locales/model_#{ locale }/#{ file_name }.yml",
              generate_yaml_file_data(
                :locale => locale,
                :singular_name => singular_name,
                :human_name => human_name,
                :attributes => attributes_hash(),
                :model_i18n_scope => model_i18n_scope()
              ) {|word| say_info "translated #{word}"}
    end

  end

  private
    def attributes_hash
      Hash[ attributes.map {|attribute| [attribute.name, attribute.type] } ]
    end

    def model_i18n_scope
      case options.orm.to_s
      when "active_model"
        :activemodel
      when "active_record"
        :activerecord
      when "mongoid"
        :mongoid
      end
    end
end

