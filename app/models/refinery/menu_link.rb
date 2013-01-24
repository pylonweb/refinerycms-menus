module Refinery
  class MenuLink < Refinery::Core::BaseModel

    attr_accessible :parent_id, :refinery_page_id, :refinery_menu_id, :refinery_resource_id, :refinery_resource_type,
                    :title_attribute, :custom_url, :label, :menu, :id_attribute, :class_attribute

    belongs_to :menu, :class_name => '::Refinery::PageMenu', :foreign_key => :refinery_menu_id
    belongs_to :resource, :foreign_key => :refinery_resource_id, :polymorphic => true

    # Docs for acts_as_nested_set https://github.com/collectiveidea/awesome_nested_set
    # rather than :delete_all we want :destroy
    acts_as_nested_set :dependent => :destroy

    validates :menu, :presence => true
    validates :label, :presence => true

    before_validation :set_label

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

    def set_label
      if label.blank?
        if custom_link?
          begin
            self.label = custom_url.match(/(\w+)\.\w+$/).captures.join.titleize
          rescue
            self.label = custom_url
          end
        else
          self.label = resource.send(resource_config[:title_attr])
        end
      end
    end

    def resource_klass
      Refinery::MenuLink.resource_klass(resource_type)
    end

    def resource_config
      Refinery::MenuLink.resource_config(resource_type)
    end

    def resource_type
      refinery_resource_type || "Custom link"
    end

    def type_name
      resource_type.titleize
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

    def resource_title
      resource.send(resource_config[:title_attr])
    end

    def title
      title_attribute.present? ? title_attribute : label
    end

    def resource_url
      resource.present? ? resource.url : '/'
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

    def to_refinery_menu_item
      {
        :id => id,
        :lft => lft,
        :menu_match => menu_match,
        :parent_id => parent_id,
        :rgt => rgt,
        :menu_title => label,
        :title => title,
        :type => self.class.name,
        :url => url
      }
    end

  end
end
