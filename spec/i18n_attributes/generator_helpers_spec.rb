#encoding: utf-8
require "spec_helper"

describe I18nAttributes::GeneratorHelpers::YamlFileData do

  def reset_subject(*options)
    options = options.extract_options!
    locale = options.delete(:locale) || :en
    singular_name = options.delete(:singular_name) || :user
    human_name = options.delete(:human_name) || :User
    attributes = options.delete(:attributes) || {"username"=>:string}
    model_i18n_scope = options.delete(:model_i18n_scope) || :activerecord
    I18nAttributes::GeneratorHelpers::YamlFileData.new(
      :locale => locale.to_s, :singular_name => singular_name.to_s, :human_name => human_name.to_s,
      :attributes => attributes.to_hash, :model_i18n_scope => model_i18n_scope.to_s )
  end

  it "instance var should set" do
    subject = reset_subject()
    subject.locale.should == 'en'
    subject.singular_name.should == "user"
    subject.human_name.should == "User"
    subject.attributes.should == {"username"=>:string}
    subject.model_i18n_scope.should == "activerecord"
  end

  context "test set_locale_translator" do
    it "when translator don't defined, locale_translator is nil" do
      I18nAttributes::Configuration.translator = {}
      subject = reset_subject(:locale => :en)
      subject.locale_translator.should be_nil
    end
    it "when translator defined, but locale is don't match reset_subject method defined locale, locale_translator is nil" do
      I18nAttributes::Configuration.translator = {:"zh-CN" => Proc.new{|str| str.to_s}}
      subject = reset_subject(:locale => :en)
      subject.locale_translator.should be_nil
    end
    it "when translator defined, but is not Proc, locale_translator is nil" do
      I18nAttributes::Configuration.translator = {:en => "test"}
      subject = reset_subject(:locale => :en)
      subject.locale_translator.should be_nil
    end
    it "when translator defined, and is a Proc, and locale match, locale_translator is Proc object" do
      I18nAttributes::Configuration.translator = {:"zh-CN" => Proc.new{|str| str.to_s}}
      subject = reset_subject(:locale => :"zh-CN")
      subject.locale_translator.should be_kind_of(Proc)
    end
  end

  context "test set_columns_hash" do
    it "if not locale_translator, columns_hash.v should eq columns_hash.k.humanize" do
      I18nAttributes::Configuration.translator = {}
      subject = reset_subject(:attributes => {"username"=>:string})
      subject.columns_hash['username'].should == "username".humanize
    end

    it "if locale_translator, columns_hash.v should eq locale_translator.call(columns_hash.k)" do
      I18nAttributes::Configuration.translator = {:"zh-CN" => Proc.new{|str| str.to_s.humanize}}
      subject = reset_subject(:locale => :"zh-CN", :attributes => {"username"=>:string})
      subject.columns_hash['username'].should == Proc.new{|str| str.to_s.humanize}.call('username')
    end
  end

  context "test generate" do
    it "yaml_file_data is a String, is YAML.dump_stream" do
      subject = reset_subject()
      subject.yaml_file_data.should be_kind_of(String)
    end
    it "YAML.load_stream yaml_file_data" do
      subject = reset_subject()
      data = YAML.load_stream(subject.yaml_file_data).first
      data['en']['activerecord']['attributes']['user']['username'].should == "Username"
    end
  end
end

describe I18nAttributes::GeneratorHelpers do
  before {
    class TestGeneratorHelpers
      include I18nAttributes::GeneratorHelpers
    end
  }

  it "should has generate_yaml_file_data" do
    TestGeneratorHelpers.new.should respond_to(:generate_yaml_file_data)
  end

  it "generate_yaml_file_data return a instance of YamlFileData" do
    TestGeneratorHelpers.new.generate_yaml_file_data(:test => true).should be_instance_of(
                                                I18nAttributes::GeneratorHelpers::YamlFileData)
  end

end

