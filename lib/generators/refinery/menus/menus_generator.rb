module Refinery
  class MenusGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def generate_menus_initializer
      template "config/initializers/refinery/menus.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "menus.rb")
    end

    def rake_db
      rake("refinery_menus:install:migrations")
    end
    
    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
              <<-EOH
      # Added by Refinery CMS Page Menus extension
      Refinery::Menus::Engine.load_seed
              EOH
      end
    end

  end
end
