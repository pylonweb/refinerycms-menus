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

      def create
        respond_to do |format|
          format.js do
            @page_positions = []
            if params[:refinery_resource_ids]
              params[:refinery_resource_ids].each do |id|
                @page_positions << PagePosition.create({refinery_resource_id: id}.merge(params[:page_position]))
              end
            else
              @page_positions << PagePosition.create(params[:page_position])
            end
          end
        end
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