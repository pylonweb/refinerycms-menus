module Refinery
  class PagePosition < Refinery::Core::BaseModel
    
    attr_accessible :parent_id, :refinery_page_id, :refinery_menu_id, :refinery_resource_id, :refinery_resource_type,
                    :title_attribute, :custom_url, :label
    
    belongs_to :menu, :class_name => '::Refinery::PageMenu', :foreign_key => :refinery_menu_id
    belongs_to :page, :class_name => '::Refinery::Page', :foreign_key => :refinery_page_id

    # Docs for acts_as_nested_set https://github.com/collectiveidea/awesome_nested_set
    # rather than :delete_all we want :destroy
    acts_as_nested_set :dependent => :destroy
    
    validates :menu, :presence => true


    def resource
      return page if refinery_page_id
      return nil if refinery_resource_id.nil? || refinery_resource_type.nil?
      resource_klass.find(refinery_resource_id)
    end

    def resource_klass
      resource_config[:klass].constantize
    end

    def resource_config
      type = refinery_resource_type || 'refinery_page'
      Refinery::PageMenus.menu_resources[type.to_sym]
    end

    def resource_url
      resource || '/'
    end

    def title
      page.title
    end
        
    def url
      if refinery_page_id.present?
        page.url
      else
        if custom_url.present?
          custom_url
        else
          resource_url
        end
      end
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
