module Refinery
  module PageMenus
    class Engine < ::Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::PageMenus
      engine_name :refinery_page_menus
      
      after_inclusion do
        ::ApplicationController.send :include, Refinery::PageMenus::InstanceMethods
      end

      config.autoload_paths += %W( #{config.root}/lib )

      initializer "register refinery_page_menus plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'page_menus'
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.admin_page_menus_path }
          plugin.pathname = root
          plugin.menu_match = /refinery\/(page_menus|main_menu|page_positions)/ #Match controller path
          # plugin.hide_from_menu = true
        end
      end

      # config.to_prepare do
      #   require 'refinerycms-pages'        
      #   Refinery::Admin::PagesController.send :has_and_belongs_to_page_menus
      # end
      
      config.after_initialize do
        Refinery.register_extension(Refinery::PageMenus)
      end
    end
  end
end
