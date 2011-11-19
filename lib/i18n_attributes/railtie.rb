module SeedUpgrade
  class Railtie < ::Rails::Railtie
    generators do
      require File.expand_path("../../generators/i18n_attributes/model/model_generator", __FILE__)
      require 'rails/generators/rails/model/model_generator'
      Rails::Generators::ModelGenerator.send(:hook_for, :i18n_attributes)
      Rails::Generators::ModelGenerator.send(:class_option, :i18n_attributes, :default => true)
    end
  end
end

