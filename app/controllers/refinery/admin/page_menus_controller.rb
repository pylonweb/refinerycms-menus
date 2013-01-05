module Refinery
  module Admin
    class PageMenusController < ::Refinery::AdminController
      
      crudify :'refinery/page_menu', :xhr_paging => true, :sortable => true
      
      before_filter :find_menu_pages, only: [:new, :edit]
      before_filter :find_page_positions, only: [:edit, :update]
      after_filter :set_page_positions, only: [:create, :update]
      
      def new
        @page_menu = PageMenu.new
      end
      
      def edit        
        @pages = Refinery::Page.all
      end
      
      private

      # Based upon http://github.com/matenia/jQuery-Awesome-Nested-Set-Drag-and-Drop
      def set_page_positions
        previous = nil
        params[:ul].each do |_, list|
          list.each do |index, hash|
            moved_item_id = hash['id'].split(/page_position\_?/).reject(&:empty?).first

            if moved_item_id
              current_position = @page_menu.positions.find(moved_item_id) # Scope?

              if current_position.respond_to?(:move_to_root)
                if previous.present?
                  current_position.move_to_right_of(@page_menu.positions.find(previous)) #SCOPE?
                else
                  current_position.move_to_root
                end
              else
                current_position.update_attributes :position => index
              end

              if hash['children'].present?
                update_child_page_positions(hash, current_position)
              end

              previous = moved_item_id
            end
          end
        end if params[:ul].present?

        PagePosition.rebuild!
      end

      def update_child_page_positions(_node, position)
        list = _node['children']['0']
        list.each do |index, child|
          child_id = child['id'].split(/page_position\_?/).reject(&:empty?).first
          child_position = @page_menu.positions.find(child_id) # Scoped?
          child_position.move_to_child_of(position)

          if child['children'].present?
            update_child_page_positions(child, child_position)
          end
        end
      end
      
      def find_menu_pages
        @pages_in_menu = Refinery::Page.in_menu
        @pages_not_in_menu = Refinery::Page.order('lft ASC') - @pages_in_menu
      end
      
      def find_page_positions
        @page_positions = @page_menu.roots
        # raise @page_positions.to_json
      end
      
    end
  end
end
