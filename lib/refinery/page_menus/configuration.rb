module Refinery
  module PageMenus
    include ActiveSupport::Configurable

    config_accessor :default_menus, :html_attributes, :menu_resources

    self.default_menus = ['sidebar_menu']
    self.html_attributes = false


    # klass: class type of resource
    # admin_partial: path to partial used in records list
    # title_attr: attribute name (or method name) on resource to be shown as its title
    # scope: a scope symbol or proc to be used for filtering objects shown to be addable via the menu edit page
    self.menu_resources = {
      refinery_page: {
        klass: 'Refinery::Page',
        title_attr: 'title',
        scope: Proc.new { live.order('lft ASC') }
      },
      refinery_resource: {
        klass: 'Refinery::Resource',
        title_attr: 'file_name'
      }
    }
   
  end
end
