#encoding: utf-8
=begin
  I18nAttributes.configure do |config|
    # more see https://github.com/svenfuchs/rails-i18n
    config.locales = [:en, :"zh-CN"]

    config.translator = {
      #you mast install youdao_fanyi, see https://github.com/vkill/youdao_fanyi
      :"zh-CN" => Proc.new{|str| YoudaoFanyi.t(str).first}

      ##you mast install and config to_lang, see https://github.com/jimmycuadra/to_lang
      #:"es" => Proc.new{|str| str.translate('es', :from => 'en') }
    }
  end
=end

module I18nAttributes
  Configuration = Struct.new(
    :locales,
    :translator
  ).new(
    [:en],
    {}
  )
end

