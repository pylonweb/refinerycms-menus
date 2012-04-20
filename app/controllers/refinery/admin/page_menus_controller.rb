module Refinery
  module Admin
    class PageMenusController < ::Refinery::AdminController
      
      crudify :'refinery/page_menu', :xhr_paging => true, :sortable => false, :redirect_to_url => "refinery.admin_page_menu_page_positions_path(@page_menu)"

    end
  end
end
