if Rails.env.development?
  I18nAttributes.configure do |config|
    # more see https://github.com/svenfuchs/rails-i18n
    config.locales = [:en, :"zh-CN"]
  end
end

