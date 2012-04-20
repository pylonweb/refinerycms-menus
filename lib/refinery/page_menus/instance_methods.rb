module Refinery
  module PageMenus
    module InstanceMethods

      def self.included(base)
        base.send :helper_method, :refinery_page_menu
      end

      # Compiles a page menu.
      def refinery_page_menu(menu_title)
        ::Refinery::PageMenu.find_or_create_by_permatitle(menu_title)
      end

    end
  end
end