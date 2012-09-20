module Refinery
  class PageMenu < Refinery::Core::BaseModel  
    
    has_many :positions, :class_name => "::Refinery::PagePosition", :foreign_key => :refinery_menu_id, :dependent => :destroy, :order => "lft ASC"
    has_many :pages, :class_name => "::Refinery::Page", :through => :positions, :foreign_key => :refinery_page_id
    
    validates :title, :presence => true, :uniqueness => true
    validates :permatitle, :presence => true, :uniqueness => true
    validates_associated :positions
    
    attr_accessible :title, :permatitle, :pages
    
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
      
    # def fast_menu(columns = [])
    #   live.in_menu.order('lft ASC').includes(:translations)
    # end

    def roots
      @roots ||= positions.select {|pos| pos.parent_id.nil?}
    end    
      
  end
end