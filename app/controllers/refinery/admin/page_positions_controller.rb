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
      
      
      def reorder
        find_all_page_positions
      end

      # Based upon http://github.com/matenia/jQuery-Awesome-Nested-Set-Drag-and-Drop
      def update_positions
        previous = nil
        params[:ul].each do |_, list|
          # After we drop Ruby 1.8.x support the following line can be changed back to
          # list.each do |index, hash|
          # because there won't be an ordering issue (see https://github.com/refinery/refinerycms/issues/1585)
          list.sort_by {|k, v| k.to_i}.map { |item| item[1] }.each_with_index do |hash, index|
            moved_item_id = hash['id'].split(/page_position\_?/).reject(&:empty?).first
            @current_page_position = PagePosition.find_by_id(moved_item_id)

            if @current_page_position.respond_to?(:move_to_root)
              if previous.present?
                @current_page_position.move_to_right_of(PagePosition.find_by_id(previous))
              else
                @current_page_position.move_to_root
              end
            else
              @current_page_position.update_attributes :position => index
            end

            if hash['children'].present?
              update_child_positions(hash, @current_page_position)
            end

            previous = moved_item_id
          end
        end

        PagePosition.rebuild! if PagePosition.respond_to?(:rebuild!)
        render :nothing => true
      end

      def update_child_positions(_node, page_position)
        list = _node['children']['0']
        list.sort_by {|k, v| k.to_i}.map { |item| item[1] }.each_with_index do |child, index|
          child_id = child['id'].split(/page_position\_?/).reject(&:empty?).first
          child_page_position = PagePosition.where(:id => child_id).first
          child_page_position.move_to_child_of(page_position)

          if child['children'].present?
            update_child_positions(child, child_page_position)
          end
        end
      end


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