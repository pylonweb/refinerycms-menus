module Refinery
  module Admin
    class PageMenusController < ::Refinery::AdminController
      
      crudify :'refinery/page_menu', :xhr_paging => true, :sortable => true#, :redirect_to_url => "refinery.admin_page_menu_page_positions_path(@page_menu)"
      
      before_filter :find_menu_pages, only: [:new, :edit]
      before_filter :find_page_positions, only: [:edit, :update]
      
      def new
        @page_menu = PageMenu.new
      end
      
      def edit        
        @pages = Refinery::Page.all
      end
      
      
      
      private
      
      def find_menu_pages
        @pages_in_menu = Refinery::Page.in_menu
        @pages_not_in_menu = Refinery::Page.order('lft ASC') - @pages_in_menu
      end
      
      def find_page_positions
        @page_positions = @page_menu.positions
      end
      
    end
  end
end
