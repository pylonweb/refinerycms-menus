module Refinery
  class PageMenusGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def generate_page_menus_initializer
      template "config/initializers/refinery/page_menus.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "page_menus.rb")
    end

    def rake_db
      rake("refinery_page_menus:install:migrations")
    end
    
    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
              <<-EOH
      # Added by Refinery CMS Page Menus extension
      Refinery::PageMenu::Engine.load_seed
              EOH
      end
    end

  end
end
