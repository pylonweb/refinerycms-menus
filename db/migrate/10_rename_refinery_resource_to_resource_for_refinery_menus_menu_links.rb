class RenameRefineryResourceToResourceForRefineryMenusMenuLinks < ActiveRecord::Migration
  def change
    rename_column :refinery_menus_links, :refinery_resource_id, :resource_id
    rename_column :refinery_menus_links, :refinery_resource_type, :resource_type
  end
end
