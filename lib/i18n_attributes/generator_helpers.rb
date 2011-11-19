require "yaml"

module I18nAttributes
  module GeneratorHelpers

    SUPPORTED_ORMS = %w(active_record active_model mongoid)

    def say_custom(type='warn', text) #example, type choise in FATAL,ERROR,WARN,INFO,DEBUG
      ansicolor = #more ansicolor => https://github.com/flori/term-ansicolor
        case type.downcase.to_s
        when 'fatal'; '31m'
        when 'error'; '31m'
        when 'warn'; '36m'
        when 'info'; '32m'
        when 'debug'; '34m'
        else; '0m'
        end
      say "\033[1m\033[#{ ansicolor }" + type.to_s.upcase.rjust(10) + "\033[0m" + "  #{text}"
    end
    def say_fatal(text); say_custom('fatal', text); exit; end
    def say_error(text); say_custom('error', text); exit; end
    def say_warn(text); say_custom('warn', text); end
    def say_info(text); say_custom('info', text); end
    def say_debug(text); say_custom('debug', text); end


    def generate_yaml_file_data(locale, singular_name, human_name, attributes_hash, orm="active_record")
      YAML.dump_stream(
        {
          locale.to_s => {
            orm.to_s => {
              "models" => {
                singular_name => human_name.to_s
              },
              "attributes" => {
                singular_name => attributes_hash.merge(enums_hash(attributes_hash.keys))
              }
            }
          }
        }
      )
    end

    private

      def enums_hash(attributes)
        enums = {}
        I18nAttributes::Configuration.enums_attributes.each do |k,v|
          attributes.index(k) ? enums.merge!(k => v) : next
        end
        enums.empty? ? {} : { "enums" => enums }
      end

  end
end

