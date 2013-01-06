# Encoding: UTF-8
require File.expand_path('../lib/refinery/page_menus/version.rb', __FILE__)

version = Refinery::PageMenus::Version.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{refinerycms-page-menus}
  s.version           = version
  s.summary           = %q{Pages Menus extension for Refinery CMS}
  s.description       = %q{Add custom menus to pages}
  s.date              = Date.today.strftime("%Y-%m-%d")
  s.email             = %q{johan@pylonweb.dk}
  s.homepage          = %q{http://github.com/pylonweb/refinerycms-page-menus}
  s.authors           = ['Johan Frølich']
  s.license           = %q{MIT}
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.add_dependency    'awesome_nested_set', '~> 2.1.0'
  s.add_dependency    'refinerycms-core', '~> 2.0.6'#'~> 2.1.0.dev'
  s.add_dependency    'refinerycms-pages', '~> 2.0.6'#'~> 2.1.0.dev'
  s.add_dependency    'nokogiri', '~> 1.5.5'
end