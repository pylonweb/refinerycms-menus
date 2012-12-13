module Refinery
  class PagePosition < Refinery::Core::BaseModel
    
    attr_accessible :parent_id, :refinery_page_id, :refinery_menu_id, :refinery_resource_id, :refinery_resource_type,
                    :title_attribute, :custom_url, :label
    
    belongs_to :menu, :class_name => '::Refinery::PageMenu', :foreign_key => :refinery_menu_id
    belongs_to :resource, :foreign_key => :refinery_resource_id, :polymorphic => true

    # Docs for acts_as_nested_set https://github.com/collectiveidea/awesome_nested_set
    # rather than :delete_all we want :destroy
    acts_as_nested_set :dependent => :destroy
    
    validates :menu, :presence => true

    def self.find_all_of_type(type)
      # find all resources of the given type, determined by the configuration
      # TODO - we may want to allow configuration of conditions (DONE), ordering, etc
      if self.resource_config(type)[:admin_page_filter]
        resource_klass(type).where(self.resource_config(type)[:admin_page_filter])
      else
        resource_klass(type).all
      end
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
      return nil if custom_link?
      resource_klass.find(refinery_resource_id)
    end

    def resource_url
      resource.present? ? resource.url : '/'
    end

    def resource_title
      resource[resource_config[:title_attr]]
    end

    def title
      title_attribute.present? ? title_attribute : label
    end
        
    def url
      if custom_link?
        custom_url
      else
        resource_url
      end
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
