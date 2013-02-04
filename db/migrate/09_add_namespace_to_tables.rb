class AddNamespaceToTables < ActiveRecord::Migration
  def change
    rename_table :refinery_menu_links, :refinery_menus_links
  end

end
