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
                singular_name => columns_hash(attributes)
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

  end
end

