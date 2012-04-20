module Refinery
  module PageMenus
    module ControllerExtension
      
      def has_and_belongs_to_page_menus
        
        before_filter :find_all_menus, :only => [:index, :list]
        
        module_eval do
          
          def list
            unless searching?
              find_all_pages
            else
              search_all_pages
            end

            render_partial_response?
          end

          def index
            unless searching?
              @pages = Refinery::Page.where(:show_in_menu => true).includes(:translations, :children).order("lft ASC")
            else
              search_all_pages
            end

            render_partial_response?
          end

          protected
    
          def find_all_menus
            @page_menus = Refinery::PageMenu.order('title ASC')
          end
          
        end
        
      end
    end
  end
end

ActionController::Base.send(:extend, Refinery::PageMenus::ControllerExtension)