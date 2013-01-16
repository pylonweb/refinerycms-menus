module Refinery
  module PageMenus
    include ActiveSupport::Configurable

    config_accessor :default_menus, :menu_resources

    self.default_menus = ['sidebar_menu']


    # klass: class type of resource
    # admin_partial: path to partial used in records list
    # title_attr: attribute name (or method name) on resource to be shown as its title
    # admin_page_filter: hash of conditions to be used for filtering objects shown to be add-able via menu edit page
    self.menu_resources = {
      refinery_page: {
        klass: 'Refinery::Page',
        title_attr: 'title',
        admin_page_filter: {
          draft: false
        }
      },
      refinery_resource: {
        klass: 'Refinery::Resource',
        title_attr: 'file_name'
      }
    }
   
  end
end
