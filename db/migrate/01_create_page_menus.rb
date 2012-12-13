class CreatePageMenus < ActiveRecord::Migration
  def up
    create_table :refinery_page_positions do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.integer :refinery_page_id
      t.integer :refinery_menu_id
      
    end
    
    add_index :refinery_page_positions, :depth
    add_index :refinery_page_positions, :id
    add_index :refinery_page_positions, :lft
    add_index :refinery_page_positions, :parent_id
    add_index :refinery_page_positions, :rgt
     
    create_table :refinery_page_menus do |t|
      t.string :title
      
      t.timestamps
    end
  end
  
  def down
    drop_table :refinery_page_positions
    drop_table :refinery_page_menus
  end

end
