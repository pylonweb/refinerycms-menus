module Refinery
  module PageMenus
    include ActiveSupport::Configurable

    config_accessor :new_menus, :default_menus, :pages_overview, :collapsible_menu, :show_hidden_pages_in_main_menu
    
    self.new_menus = false
    self.default_menus = ['sidebar_menu']
    self.pages_overview = true
    self.collapsible_menu = true
    self.show_hidden_pages_in_main_menu = false
   
  end
end
