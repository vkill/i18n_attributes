# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "i18n_attributes/version"

Gem::Specification.new do |s|
  s.name        = "i18n_attributes"
  s.version     = I18nAttributes::VERSION
  s.authors     = ["vkill"]
  s.email       = ["vkill.net@gmail.com"]
  s.homepage    = ""
  s.summary     = "A generate model attributes I18n locale files plugin for Rails3."
  s.description = "A generate model attributes I18n locale files plugin for Rails3."

  s.rubyforge_project = "i18n_attributes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'bundler'
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails"

  #translate attribute use
  s.add_development_dependency "youdao_fanyi"

  #use in spec/rails3_0_app
  s.add_development_dependency "rails", "~> 3.0"
  s.add_development_dependency "sqlite3-ruby"

  s.add_dependency "rails", "~> 3.0"
  s.add_dependency "activesupport", "~> 3.0"
  s.add_dependency "vkill_gems_methods", "~> 0.1.0"
end

