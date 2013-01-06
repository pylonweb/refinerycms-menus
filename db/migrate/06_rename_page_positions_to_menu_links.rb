class RenamePagePositionsToMenuLinks < ActiveRecord::Migration
  def change
  	rename_table :refinery_page_positions, :refinery_menu_links
  end
end
