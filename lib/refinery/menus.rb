require 'refinerycms-core'

require 'refinery/menu_item_decorator'

module Refinery
  autoload :MenusGenerator, 'generators/refinery/menus/menus_generator'
  
  module Menus
    require 'refinery/menus/engine'
    require 'refinery/menus/configuration'
    
    autoload :InstanceMethods, 'refinery/menus/instance_methods'

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
    
  end
end


ActiveSupport.on_load(:active_record) do
  require 'awesome_nested_set'
end
