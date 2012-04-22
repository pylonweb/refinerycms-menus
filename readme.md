# Page Menus Extension for Refinery CMS

## IMPORTANT: IN DEVELOPMENT!

This extension is still in development! There is no tests yet. 
Also you can't create new menus in the admin interface, you have to create them yourself.

A stable complete version will soon be released.

If you are willing to contribute please send me a mail (johan@pylonweb.dk), and follow the contribution guidelines below. Especially test would be appriciated!

## About

Page menus allows you to create and edit several custom menus for your Refinery CMS app. 

## Requirements

* refinerycms >= 2.0.0

## Install

Add this line to your applications `Gemfile`

```ruby
gem 'refinerycms-page-menus', '~> 2.0.0'
```

or for edge version

```ruby
gem 'refinerycms-page-menus', git: 'git@github.com:pylonweb/refinerycms-page-menus.git'
```

Next run

```bash
bundle install
rails generate refinery:page_menus
rake db:migrate
```

Now when you start up your Refinery application, go to the pages in your admin interface, and you should see a roll-down menu called "Menus".

## Usage

`app/views/refinery/pages/header.html.erb`

If you don't have this file then Refinery will be using its default. You can override this with

```bash
rake refinery:override view=refinery/header
```

```erb
== render :partial => "/refinery/menu", :locals => { 
				:roots => refinery_page_menu("custom_menu").roots
	          }	          	          
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request