require 'refinerycms-core'

module Refinery
  autoload :PageMenusGenerator, 'generators/refinery/page_menus/page_menus_generator'
  autoload :InstanceMethods, 'refinery/page_menus/admin/instance_methods'
  
  module PageMenus
    require 'refinery/page_menus/engine'
    require 'refinery/page_menus/configuration'
    require 'refinery/page_menus/model_extension'
    require 'refinery/page_menus/controller_extension'
    
    autoload :InstanceMethods, 'refinery/page_menus/instance_methods'

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
    
  end
end


ActiveSupport.on_load(:active_record) do
  require 'awesome_nested_set'
end
