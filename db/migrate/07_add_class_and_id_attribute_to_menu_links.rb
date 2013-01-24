class AddClassAndIdAttributeToMenuLinks < ActiveRecord::Migration
  def change
    add_column :refinery_menu_links, :id_attribute, :string
    add_column :refinery_menu_links, :class_attribute, :string
  end
end
