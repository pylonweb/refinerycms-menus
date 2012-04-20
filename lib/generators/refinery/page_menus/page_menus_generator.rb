module Refinery
  class PageMenusGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def rake_db
      rake("refinery_page_menus:install:migrations")
    end
    
    def generate_pages_initializer
      template "config/initializers/refinery/page_menus.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "page_menus.rb")
    end

  end
end
