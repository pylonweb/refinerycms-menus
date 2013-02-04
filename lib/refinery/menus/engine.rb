module Refinery
  module Menus
    class Engine < ::Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Menus
      engine_name :refinery_menus
      
      after_inclusion do
        ::ApplicationController.send :include, Refinery::Menus::InstanceMethods
      end

      config.autoload_paths += %W( #{config.root}/lib )

      initializer "register refinery_menus plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'refinery_menus'
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.admin_menus_path }
          plugin.pathname = root
          plugin.menu_match = /refinery\/(menus|menu_links)/ #Match controller path
        end
      end
      
      config.after_initialize do
        Refinery.register_extension(Refinery::Menus)
      end
    end
  end
end
