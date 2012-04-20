# Encoding: UTF-8
# $:.push File.expand_path('../../core/lib', __FILE__)
# require 'refinery/version'
# 
# version = Refinery::Version.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{refinerycms-page-menus}
  s.version           = '2.0.3'
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
  s.add_dependency    'refinerycms-pages',  '~> 2.0.3'
end