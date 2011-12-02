module I18nAttributes
  module GeneratorHelpers

    def generate_yaml_file_data(*options, &block)
      YamlFileData.new(options, &block)
    end

    class YamlFileData

      attr_reader :locale, :singular_name, :human_name, :attributes, :model_i18n_scope,
                  :locale_translator, :columns_hash, :yaml_file_data

      def initialize(*options, &block)
        options = options.extract_options!
        return self if test = options.delete(:test) || false

        @locale = options.delete(:locale).to_s || raise "locale is required."
        @singular_name = options.delete(:singular_name).to_s || raise "singular_name is required."
        @human_name = options.delete(:human_name).to_s || raise "human_name is required."
        @attributes = options.delete(:attributes).to_hash || raise "attributes is required."
        @model_i18n_scope = options.delete(:model_i18n_scope).to_s || raise "model_i18n_scope is required."

        set_locale_translator()
        set_columns_hash()
        generate()
        @yaml_file_data
      end

      def generate
        @yaml_file_data =
          YAML.dump_stream(
            {
              locale => {
                model_i18n_scope => {
                  "models" => {
                    singular_name => human_name
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
                    if @locale_translator
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
        locale_translator = translator[@locale.to_sym] || translator[@locale.to_sym]
        @locale_translator =
          if !locale_translator.blank? and locale_translator.class == Proc
            locale_translator
          else
             nil
          end
      end
    end

  end
end

