require "yaml"

module I18nAttributes
  module GeneratorHelpers

    def generate_yaml_file_data(locale, singular_name, human_name, attributes, orm="active_record", model_i18n_scope="activerecord")
      YAML.dump_stream(
        {
          locale.to_s => {
            model_i18n_scope.to_s => {
              "models" => {
                singular_name => human_name.to_s
              },
              "attributes" => {
                singular_name => columns_hash(attributes).merge(enums_hash(attributes))
              }
            }
          }
        }
      )
    end

    private
      def columns_hash(attributes)
        Hash[ attributes.keys.map {|k| [k.to_s, k.to_s.humanize]} ]
      end

      def enums_hash(attributes)
        enums = {}
        I18nAttributes::Configuration.enums_attributes.each do |k,v|
          attributes.keys.index(k) ? enums.merge!(k => v) : next
        end
        enums.empty? ? {} : { "enums" => enums }
      end

  end
end

