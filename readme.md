# Menus extension for Refinery CMS

[![Build Status](https://travis-ci.org/pylonweb/refinerycms-menus.png?branch=master)](https://travis-ci.org/pylonweb/refinerycms-menus)
[![Dependency Status](https://gemnasium.com/pylonweb/refinerycms-menus.png)](https://gemnasium.com/pylonweb/refinerycms-menus)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/pylonweb/refinerycms-menus)
<!--[![Gem Version](https://badge.fury.io/rb/refinerycms-menus.png)](http://badge.fury.io/rb/refinerycms-menus)-->
## About

Refinery Menus allows you to create and edit several custom menus for your Refinery CMS app. It gives you the ability to add links to any kind of model you want. As default are custom links (fx http://google.com, http://github.com etc.) Refinery Pages and Refinery Resources (files). See the screenshot below for an example.

## Requirements

* refinerycms >= 2.0.6

## Features

* Ability to create more than one menu for your application.
* Ability to link to any number of custom models you want.
* Ability to link to any custom url.
* Simple and easy-to-use interface.

## Install

Add this line to your applications `Gemfile`

```ruby
gem 'refinerycms-menus', '~> 2.0.7'
```

or for edge version

```ruby
gem 'refinerycms-menus', git: 'git://github.com/pylonweb/refinerycms-menus.git'
```

Next run

```bash
bundle install
rails generate refinery:menus
rake db:migrate
```

Now when you start up your Refinery application, you should see a new menus tap in the admin interface.

## Update

Refinerycms Menus is still fairly new, and some updates include new database migrations, even on 2.0.X releases. You should therefore always remember to run the following after updating Refinerycms Menus:

```bash
rails generate refinery:menus
rake db:migrate
```

If you have made changes to the `config/initializers/refinery/menus.rb` file then remember not to overwrite it when running the generator.

## Usage
### Add to your view

Go to `app/views/refinery/pages/_header.html.erb` in your application.
If you don't have this file then Refinery will be using its default. You can override this with

```bash
rake refinery:override view=refinery/_header
```

Then add this code to the header, to generate the custom menu:
```erb
<%= render :partial => "/refinery/menu", :locals => {
      :roots => refinery_menu("custom_menu")
    } %>
```
"custom_menu" must be replaced by the permatitle of your menu.
### Rake commands
To show list all your menus and their permatitles run this rake task:
```bash
rake refinery:menus:list
```

You can create a new menu in the rails console, or you can use the following command:
```bash
rake refinery:menus:create_menu title=some_title
```
### Configuration
Refinerycms Menus is very flexible and is very easy to setup your own models, so you can link to them in your menus. To add a new model to Refinerycms Menus, just go to the config file (`config/initializers/refinery/menus.rb`) and follow the instructions on how to add your model to the `menu_resources` configuration option.

Your model only have to respond to two methods:

* `url` which must define which path the menu link should link to.
*  A custom title method that you can specify in the configuration.

Here is a example of how Refinery Pages are added as a custom resource model:

```ruby
config.menu_resources = refinery_page: {
                klass: 'Refinery::Page',
                title_attr: 'title',
                scope: Proc.new { live.order('lft ASC') }
             }
```

## Questions, problems and contributions

We will very much appreciate all kinds of contributions to refinerycms-menus! Just fork this project, create a new feature branch and open up a pull request. If you don't know how to do this, try to check out [RailsCasts episode 300](http://railscasts.com/episodes/300-contributing-to-open-source). If you are able, please add tests to your pull requests.

If you have any issues or questions, that you cannot find the answer to here, then please feel free to add an [issue on GitHub](https://github.com/pylonweb/refinerycms-menus/issues/new).

### Running tests
Refinery Menus uses RSpec to test. See the documentation on [RSpec GitHub page](https://github.com/rspec/rspec).

1. To run the test suite, you must first install a dummy refinery app to test against: `bundle exec refinery:testing:dummy_app`. See the [Refinery Testing Guide](http://refinerycms.com/guides/testing) for more info.
2. You can run all specs by running the command `bundle exec rake`.

## Screenshot

![image](https://raw.github.com/pylonweb/refinerycms-menus/master/doc/refinery_menu_edit.png)
