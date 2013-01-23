# Page Menus Extension for Refinery CMS

<!--
[![Build Status](https://travis-ci.org/pylonweb/refinerycms-page-menus.png)](https://travis-ci.org/pylonweb/refinerycms-page-menus)
https://codeclimate.com/github/pylonweb/refinerycms-page-menus
https://gatekeeper.tech-angels.net/account
-->

## About

Page menus allows you to create and edit several custom menus for your Refinery CMS app. It gives you the ability to add links to any kind of model you want. As default are custom links (fx http://google.com, http://github.com etc.) Refinery Pages and Refinery Resources (files). See the screenshot below for an example.

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
gem 'refinerycms-page-menus', '~> 2.0.6'
```

or for edge version

```ruby
gem 'refinerycms-page-menus', git: 'git://github.com/pylonweb/refinerycms-page-menus.git'
```

Next run

```bash
bundle install
rails generate refinery:page_menus
rake db:migrate
```

Now when you start up your Refinery application, go to the pages in your admin interface, and you should see a roll-down menu called "Menus".

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
			:roots => refinery_page_menu("custom_menu")
	  }	%>
```
"custom_menu" must be replaced by the permatitle of your menu.
### Rake commands
To show list all your menus and their permatitles run this rake task:
```bash
rake refinery:page_menus:menus
```

You can create a new menu in the rails console, or you can use the following command:
```bash
rake refinery:page_menus:create_menu title=some_title
```
### Configuration
Refinerycms Page Menus is very flexible and is very easy to setup your own models, so you can link to them in your menus. To add a new model to Refinerycms Page Menus, just go to the config file (`config/initializers/refinery/page_menus.rb`) and follow the instructions on how to add your model to the `menu_resources` configuration option.

Your model only have to respond to two methods:

* `url` which must define which path the menu link should link to.
*  A custom title method that you can specify in the configuration.

Here is a example of how Refinery Pages are added as a custom resource model:

```ruby
config.menu_resources = refinery_page: {
  							klass: 'Refinery::Page',
  							title_attr: 'title',
  							admin_page_filter: {
   				 				draft: false
  							}
						 }
```

## Questions, problems and contributions

We will very much appreciate all kinds of contributions to refinerycms-page-menus! Just fork this project, create a new feature branch and open up a pull request. If you don't know how to do this, try to check out [RailsCasts episode 300](http://railscasts.com/episodes/300-contributing-to-open-source). If you are able, please add tests to your pull requests.

If you have any issues or questions, that you cannot find the answer to here, then please feel free to add an [issue on GitHub](https://github.com/refinery/refinerycms-page-images/issues/new).

### Running tests
Refinery Page Menus uses RSpec to test. See the documentation on [RSpec GitHub page](https://github.com/rspec/rspec).

1. To run the test suite, you must first install a dummy refinery app to test against: `bundle exec refinery:testing:dummy_app`. See the [Refinery Testing Guide](http://refinerycms.com/guides/testing) for more info.
2. You can run all specs by running the command `bundle exec rake`.

## Screenshot

![image](https://raw.github.com/pylonweb/refinerycms-page-menus/master/doc/refinery_menu_edit.png)
