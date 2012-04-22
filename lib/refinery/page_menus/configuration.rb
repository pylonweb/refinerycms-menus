module Refinery
  module PageMenus
    include ActiveSupport::Configurable

    config_accessor :new_menus, :default_menus
    
    self.new_menus = false
    self.default_menus = ['sidebar_menu']
   
  end
end
