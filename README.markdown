#I18nAttributes

I18nAttributes is a generate model attributes I18n locale files plugin for Rails3.

* https://github.com/vkill/i18n_attributes

##Supported versions

* Ruby 1.8.7, 1.9.2, 1.9.3

* Rails 3.0.x, 3.1


##Installation

In your app's `Gemfile`, add:

    gem "i18n_attributes"

Then run:

    > bundle
    > rails generate i18n_attributes:install

If your want to configure, see `config/initializers/i18n_attributes.rb`


##Uninstallation

Run:

    > rails destroy i18n_attributes:install


##Usage Example

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


##Copyright

Copyright (c) 2011 vkill.net .

