module Refinery
  class PageMenu < Refinery::Core::BaseModel  
    
    has_many :positions, :class_name => "::Refinery::PagePosition", :foreign_key => :refinery_menu_id, :dependent => :destroy, :order => "lft ASC"
    
    validates :title, :presence => true, :uniqueness => true
    validates :permatitle, :presence => true, :uniqueness => true
    validates_associated :positions
    
    attr_accessible :title, :permatitle, :positions, :positions_attributes

    accepts_nested_attributes_for :positions, :allow_destroy => true

    def roots
      @roots ||= positions.select {|pos| pos.parent_id.nil?}
    end    
      
  end
end