class AddFlexFieldsToPagePositions < ActiveRecord::Migration
  def change
    add_column :refinery_page_positions, :refinery_resource_id, :integer
    add_column :refinery_page_positions, :refinery_resource_type, :string
    add_column :refinery_page_positions, :title_attribute, :string
    add_column :refinery_page_positions, :custom_url, :string
    add_column :refinery_page_positions, :label, :string
  end
end
