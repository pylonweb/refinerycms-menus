module Refinery
  class PageMenu < Refinery::Core::BaseModel  
    
    has_many :positions, :class_name => "::Refinery::PagePosition", :foreign_key => :refinery_menu_id, :dependent => :destroy, :order => "lft ASC"
    
    validates :title, :presence => true, :uniqueness => true
    validates :permatitle, :presence => true, :uniqueness => true
    validates_associated :positions
    
    attr_accessible :title, :permatitle, :positions, :positions_attributes

    accepts_nested_attributes_for :positions, :allow_destroy => true

    def pages=(new_ids)
      old_ids = positions.map(&:refinery_page_id)
      (new_ids - old_ids).each do |id|
        positions.build(:refinery_page_id => id) if !id.empty?
      end
      (old_ids - new_ids).each do |id|
        positions.where(:refinery_page_id => id).destroy_all
      end
      self.save
    end

    def roots
      @roots ||= positions.select {|pos| pos.parent_id.nil?}
    end    
      
  end
end