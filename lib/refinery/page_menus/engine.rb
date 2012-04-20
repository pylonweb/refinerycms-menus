module Refinery
  module PageMenus
    class Engine < ::Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery
      engine_name :refinery_page_menus
      
      after_inclusion do
        ::ApplicationController.send :include, Refinery::PageMenus::InstanceMethods
      end

      config.autoload_paths += %W( #{config.root}/lib )

      initializer "register refinery_page_menus plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'refinery_page_menus'
          plugin.hide_from_menu = true
        end
      end

      config.to_prepare do
        require 'refinerycms-pages'
        
        Refinery::Page.send :has_many_page_menus
        Refinery::Admin::PagesController.send :has_and_belongs_to_page_menus
      end
      
      config.after_initialize do
        Refinery.register_extension(Refinery::PageMenus)
      end
    end
  end
end
