module I18nAttributes
  module GeneratorHelpers

    def generate_yaml_file_data(*options, &block)
      YamlFileData.new(options, &block)
    end

    class YamlFileData
      def initialize(*options, &block)
        options = options.extract_options!
        @locale = options.delete(:locale) || raise "locale is required."
        @singular_name = options.delete(:singular_name) || raise "singular_name is required."
        @human_name = options.delete(:human_name) || raise "human_name is required."
        @attributes = options.delete(:attributes) || raise "attributes is required."
        @model_i18n_scope = options.delete(:model_i18n_scope) || raise "model_i18n_scope is required."

        set_locale_translator()
        set_columns_hash()
        generate()
      end

      def generate
        YAML.dump_stream(
          {
            locale.to_s => {
              model_i18n_scope.to_s => {
                "models" => {
                  singular_name => human_name.to_s
                },
                "attributes" => {
                  singular_name => @columns_hash
                }
              }
            }
          }
        )
      end

      def set_columns_hash(&block)
        @columns_hash =
          Hash[ @attributes.keys.map {|k|
                  [
                    k.to_s,
                    if @locale_translator.class == Proc
                      yield k.to_s if block
                      @locale_translator.call(k.to_s)
                    else
                      k.to_s.humanize
                    end
                  ]
                }
              ]
      end

      def set_locale_translator
        translator = I18nAttributes::Configuration.translator
        @locale_translator = translator[@locale.to_sym] || translator[@locale.to_sym]
      end
    end

  end
end

