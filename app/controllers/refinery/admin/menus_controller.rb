module Refinery
  module Admin
    class MenusController < ::Refinery::AdminController
      
      crudify :'refinery/menu', 
              :xhr_paging => true, 
              :sortable => false,
              :include => [:links],
              :redirect_to_url => "refinery.admin_menus_path"
      
      before_filter :find_menu_links, only: [:edit, :update]
      before_filter :set_links_positions, only: [:create, :update]
      
      private

      # Based upon http://github.com/matenia/jQuery-Awesome-Nested-Set-Drag-and-Drop
      def set_links_positions
        previous = nil
        # raise params.inspect
        params[:ul].each do |_, list|
          list.each do |index, hash|
            moved_item_id = hash['id'].split(/menu_link\_?/).reject(&:empty?).first

            if moved_item_id
              current_link = @menu.links.find(moved_item_id) # Scope?

              if current_link.respond_to?(:move_to_root)
                if previous.present?
                  current_link.move_to_right_of(@menu.links.find(previous)) #SCOPE?
                else
                  current_link.move_to_root
                end
              else
                current_link.update_attributes :position => index
              end

              if hash['children'].present?
                update_child_links_positions(hash, current_link)
              end

              previous = moved_item_id
            end
          end
        end if params[:ul].present?

        MenuLink.rebuild!
      end

      def update_child_links_positions(_node, link)
        list = _node['children']['0']
        list.each do |index, child|
          child_id = child['id'].split(/menu_link\_?/).reject(&:empty?).first
          child_link = @menu.links.find(child_id) # Scoped?
          child_link.move_to_child_of(link)

          if child['children'].present?
            update_child_links_positions(child, child_link)
          end
        end
      end
      
      def find_menu_links
        @menu_links = @menu.roots
      end
      
    end
  end
end
