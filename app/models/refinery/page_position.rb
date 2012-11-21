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

    def self.find_all_of_type(type)
      # find all resources of the given type, determined by the configuration
      resource_klass(type).all
    end

    def self.resource_klass(type)
      resource_config(type)[:klass].constantize
    end

    def self.resource_config(type)
      Refinery::PageMenus.menu_resources[type.to_sym]
    end

    def resource_klass
      Refinery::PagePosition.resource_klass(resource_type)
    end

    def resource_config
      Refinery::PagePosition.resource_config(resource_type)
    end

    def resource_type
      refinery_resource_type || 'refinery_page'
    end

    def custom_link?
      refinery_resource_id.nil? || refinery_resource_type.nil?
    end

    def resource_link?
      refinery_resource_id.present? && refinery_resource_type.present?
    end

    def resource
      return page if refinery_page_id # for now, until we phase out 'refinery_page_id'
      return nil if custom_link?
      resource_klass.find(refinery_resource_id)
    end

    def resource_url
      resource || '/'
    end

    def resource_title
      resource[resource_config[:title_attr]]
    end

    def title
      page.title
    end
        
    def url
      if refinery_page_id.present?
        page.url
      else
        if custom_link?
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

    def as_json(options={})
      json = super(options)
      if resource_link?
        json = {
          resource: {
            title: resource_title
          }
        }.merge(json)
      end
      json
    end
    
  end
end
