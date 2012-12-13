class AddPermatitleToPageMenus < ActiveRecord::Migration
  def change
    add_column :refinery_page_menus, :permatitle, :string
    
    add_index :refinery_page_menus, :permatitle, :unique => true

  end
  
end
