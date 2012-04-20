module Refinery
  module PageMenus
    module ModelExtension
      
      def has_many_page_menus
        has_many :positions, :class_name => '::Refinery::PagePosition', :foreign_key => :refinery_page_id, :dependent => :destroy
        has_many :menus, :through => :positions, :class_name => '::Refinery::PageMenu', :foreign_key => :refinery_menu_id
      end
      
    end
  end
end

ActiveRecord::Base.send(:extend, Refinery::PageMenus::ModelExtension)