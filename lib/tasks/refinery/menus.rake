namespace :refinery do

  namespace :menus do

    desc "Create a new menu"
    task :create_menu => :environment do
    	permatitle = ENV['permatitle'] || ENV['perma']
    	title = ENV['title']
    	if title
  			permatitle = title.gsub(' ', '_').underscore if permatitle.nil?
    		begin
    			menu = Refinery::Menus::Menu.create!(title: title, permatitle: permatitle)
       		puts "Created new menu with title '#{title}' and permatitle '#{permatitle}'"
    			puts "To use this menu in your views, paste this code into your view file:"
    			puts "<%= render :partial => '/refinery/menu', :locals => { "
    			puts "           :roots => refinery_menu('#{permatitle}') } %>"
	    	rescue Exception => e
	    		puts e
	    	end
    	else
    		puts "You didn't specify a title for your menu. Here are some examples:"
    		puts "rake refinery:menus:create_menu title='Top Menu'"
    		puts "rake refinery:menus:create_menu permatitle=footer_menu"
    		puts "rake refinery:menus:create_menu title='Sitebar Menu' permatitle=sitebar_menu"
    		puts ""
    		puts "If not presnce permatitles will be underscored version of the title input, ie:"
    		puts "title='Top Menu' will result in the permatitle 'top_menu'"
    	end
    end

    desc "Lists all menus"
    task :list => :environment do
  		begin
  			menus = Refinery::Menus::Menu.all

				if menus.none?
					puts "You don't have any menus."
					puts "To create a new menu, run this rake task:"
					puts "rake refinery:menus:create_menu title='your menu title'"
				elsif menus.one?
					puts "You have the one menu '#{menus.first.title}' with the permatitle '#{menus.first.permatitle}'."
					puts ""
				  puts "To use '#{menus.first.title}' in your views, paste this code into your view file:"
					puts "<%= render :partial => '/refinery/menu', :locals => { "
					puts "           :roots => refinery_menu('#{menus.first.permatitle}') } %>"
				elsif menus.many?
					puts "Your have the following menus:"
					menus.each do |menu|
						puts "'#{menu.title}' with permatitle '#{menu.permatitle}'"
					end
					puts ""
				  puts "To use one of these menus in your views, paste this code into your view file:"
					puts "<%= render :partial => '/refinery/menu', :locals => { "
					puts "           :roots => refinery_menu('<PERMATITLE>') } %>"
					puts "and replace <PERMATITLE> with the permatitle for the choosen menu"
				end

    	rescue Exception => e
    		puts e
    	end
    end

  end

end