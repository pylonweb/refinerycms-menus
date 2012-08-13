module Refinery
  class PagePosition < Refinery::Core::BaseModel
    
    attr_accessible :parent_id, :refinery_page_id, :refinery_menu_id
    
    belongs_to :menu, :class_name => '::Refinery::PageMenu', :foreign_key => :refinery_menu_id
    belongs_to :page, :class_name => '::Refinery::Page', :foreign_key => :refinery_page_id

    # Docs for acts_as_nested_set https://github.com/collectiveidea/awesome_nested_set
    # rather than :delete_all we want :destroy
    acts_as_nested_set :dependent => :destroy
    
    validates :page, :presence => true
    validates :menu, :presence => true
    
    def title
      page_title_with_translations page.title
    end
        
    def url
      page.url
    end
    
    def url=(value)
      page.url = value
    end
    
    def original_id
      page.id
    end
    
    def original_type
      page.type
    end
    
  end
end
