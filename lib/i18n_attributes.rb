require "i18n_attributes/version"

require "i18n_attributes/configuration"
require "rails"
require "i18n_attributes/railtie"
require "i18n_attributes/generator_helpers"

module I18nAttributes
  def self.configure
    yield Configuration
  end
end

