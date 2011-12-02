#I18nAttributes

I18nAttributes is a generate model attributes I18n locale files plugin for Rails3.

* https://github.com/vkill/i18n_attributes

##Supported versions

* Ruby 1.8.7, 1.9.2, 1.9.3

* Rails 3.0.x, 3.1


##Installation

In your app's `Gemfile`, add:

    gem "i18n_attributes", :group => [:development]

Then run:

    > bundle
    > rails generate i18n_attributes:install

If your want to configure, see `config/initializers/i18n_attributes.rb`


##Uninstallation

Run:

    > rails destroy i18n_attributes:install


##Usage Example

###Basic Usage

When your generate post model, then hook invoke, create `config/locales/model_zh-CN/post.yml` file

    > rails g model post title:string
        invoke  active_record
        create    db/migrate/20111119121327_create_posts.rb
        create    app/models/post.rb
        invoke    test_unit
        create      test/unit/post_test.rb
        create      test/fixtures/posts.yml
        invoke  i18n_attributes
        create    config/locales/model_en/post.yml
        create    config/locales/model_zh-CN/post.yml

If your models has been created, you want generate model attributes i18n locale file,very easy also, run

    > rails g i18n_attributes:revise_model
        create  config/locales/model_en/post.yml
        create  config/locales/model_zh-CN/post.yml

###Translate attribute

If you want translate attribute or model name

First, edit `config/initializers/i18n_attributes.rb` file, like this

    if Rails.env.development?
      I18nAttributes.configure do |config|
        config.locales = [:en, :"zh-CN"]
        config.translator = {
          ##if use this, you mast install youdao_fanyi, see https://github.com/vkill/youdao_fanyi
          :"zh-CN" => Proc.new{|str| YoudaoFanyi.t(str).first}
        }
      end
    end

Then, install `youdao_fanyi`, see https://github.com/vkill/youdao_fanyi. you also use `to _lang` and more.

Last, run `rails g i18n_attributes:revise_model`, results like this

    > rails g i18n_attributes:revise_model
      create  config/locales/model_en/user.yml
      INFO  translated attribute/model_name id
      INFO  translated attribute/model_name username
      INFO  translated attribute/model_name created_at
      INFO  translated attribute/model_name updated_at
      INFO  translated attribute/model_name User
      create  config/locales/model_zh-CN/user.yml

    > cat config/locales/model_zh-CN/user.yml
      ---
      zh-CN:
        activerecord:
          models:
            user: 用户
          attributes:
            user:
              id: id
              username: 用户名
              created_at: created_at
              updated_at: updated_at


##Copyright

Copyright (c) 2011 vkill.net .

