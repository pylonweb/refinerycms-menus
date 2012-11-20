module Refinery
  module PageMenus
    include ActiveSupport::Configurable

    config_accessor :new_menus, :default_menus, :pages_overview, :collapsible_menu, :show_hidden_pages_in_main_menu,
                    :menu_resources
    
    self.new_menus = false
    self.default_menus = ['sidebar_menu']
    self.pages_overview = true
    self.collapsible_menu = true
    self.show_hidden_pages_in_main_menu = false

    self.menu_resources = {
      refinery_page: {
        klass: 'Refinery::Page',
        admin_partial: '/refinery/admin/page_positions/page_position'
      },
      refinery_blog_post: {
        klass: 'Refinery::Blog::Post',
        admin_partial: '/refinery/blog/admin/posts/post'
      }
    }
   
  end
end
