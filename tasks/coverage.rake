desc "Run tests with coverage"
namespace :coverage do
	task :run do
	  ENV['COVERAGE'] = "true"
	  Rake::Task["spec"].execute
	  Launchy.open("file://" + File.expand_path("../../coverage/index.html", __FILE__))
	end

	task :open do
		Launchy.open("file://" + File.expand_path("../../coverage/index.html", __FILE__))
	end
end

task :coverage => ["coverage:run"]