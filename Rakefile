require 'bundler'
Bundler::GemHelper.install_tasks

ENGINE_PATH = File.dirname(__FILE__)
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

if File.exists?(APP_RAKEFILE)
  load 'rails/tasks/engine.rake'
end

require "refinerycms-testing"
Refinery::Testing::Railtie.load_tasks
Refinery::Testing::Railtie.load_dummy_tasks(ENGINE_PATH)

load File.expand_path('../tasks/rspec.rake', __FILE__)

task :default => :spec

desc "Run tests with coverage"
namespace :coverage do
	task :run do
	  ENV['COVERAGE'] = "true"
	  Rake::Task["spec"].execute
	  Launchy.open("file://" + File.expand_path("../coverage/index.html", __FILE__))
	end

	task :open do
		Launchy.open("file://" + File.expand_path("../coverage/index.html", __FILE__))
	end
end

task :coverage => ["coverage:run"]