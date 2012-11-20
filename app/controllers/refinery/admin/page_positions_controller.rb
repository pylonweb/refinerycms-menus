module Refinery
  module Admin
    class PagePositionsController < Refinery::AdminController

      crudify :'refinery/page_position',
              :order => "lft ASC",
              :include => [:children],
              :paging => false

      helper :'refinery/page_positions'
      helper :'refinery/admin/pages'
              
      before_filter :find_all_menus, :find_menu, :only => [:index, :update_positions]

      # after_filter lambda{::Refinery::Page.expire_page_caching}, :only => [:update_positions]

      # before_filter :restrict_access, :only => [:create, :update, :update_positions, :destroy],
      #                 :if => proc { Refinery.i18n_enabled? }


      def children
        @page_position = find_page_position
        render :layout => false
      end

    protected

      def find_all_page_positions(conditions = '')
        @page_positions = @page_menu.positions.where(conditions).order('lft ASC') 
      end

      def find_menu
        if params[:page_menu_id]
          @page_menu = Refinery::PageMenu.find(params[:page_menu_id]) 
        end
      end

      def find_all_menus
        @page_menus = Refinery::PageMenu.order('title ASC')
      end
  
      # def restrict_access
      #   if current_refinery_user.has_role?(:translator) && !current_refinery_user.has_role?(:superuser) &&
      #        (params[:switch_locale].blank? || params[:switch_locale] == Refinery::I18n.default_frontend_locale.to_s)
      #     flash[:error] = t('translator_access', :scope => 'refinery.admin.pages')
      #     redirect_to refinery.admin_pages_path
      #   end
      # 
      #   return true
      # end

    end
  end
end