module Refinery
  module Admin
    class PageMenusController < ::Refinery::AdminController
      
      crudify :'refinery/page_menu', :xhr_paging => true, :sortable => false, :redirect_to_url => "refinery.admin_page_menu_page_positions_path(@page_menu)"

      def edit_main_menu
      end
      
      def update_main_menu 
        Refinery::Page.all.each do |page|
          if params[:page_menu][:pages].include?(page.id.to_s) && !page.show_in_menu?
            page.update_attribute(:show_in_menu, true)
          elsif !params[:page_menu][:pages].include?(page.id.to_s) && page.show_in_menu?
            page.update_attribute(:show_in_menu, false)
          end
        end
        
        redirect_to refinery.admin_pages_main_menu_path
      end
      
    end
  end
end
