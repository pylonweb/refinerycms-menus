module Refinery
  class PageMenu < Refinery::Core::BaseModel  
    
    has_many :positions, :class_name => "::Refinery::PagePosition", :foreign_key => :refinery_menu_id, :dependent => :destroy, :order => "lft ASC"
    has_many :pages, :class_name => "::Refinery::Page", :through => :positions, :foreign_key => :refinery_page_id
    
    validates :title, :presence => true, :uniqueness => true
    validates :permatitle, :presence => true, :uniqueness => true
    validates_associated :positions
    
    attr_accessible :title, :permatitle, :pages, :page_positions

    def page_positions=(pp_arr)
      ap pp_arr
      pp_arr.each do |page_position|
        ap page_position
        id = page_position["id"]
        id = id.to_i if id.present?
        page_position.delete("id")
        if page_position["deleted"] == "true" && id.present?
          # delete this page position
          positions.find_by_id(id).destroy
        else
          # update or create this page position
          page_position.delete("deleted")
          if id.present?
            positions.find_by_id(id).update_attributes(page_position)
          else
            positions.build(page_position).save
          end
        end
      end
    end
    
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