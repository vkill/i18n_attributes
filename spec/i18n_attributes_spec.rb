#encoding: utf-8
require "spec_helper"

describe I18nAttributes do
  it "should configure" do
    lambda {
      I18nAttributes.configure do |config|
        config.locales = [:en]
      end
    }.should_not raise_error()
  end

end

