# Page Menus Extension for Refinery CMS
[![Build Status](https://travis-ci.org/pylonweb/refinerycms-page-menus.png)](https://travis-ci.org/pylonweb/refinerycms-page-menus)
If you are willing to contribute please send me a mail (johan@pylonweb.dk), and follow the contribution guidelines below. Especially test would be appriciated!

## About

Page menus allows you to create and edit several custom menus for your Refinery CMS app. 

![image](https://raw.github.com/pylonweb/refinerycms-page-menus/master/doc/refinery_menu_edit.png)

## Requirements

* refinerycms >= 2.0.6

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
