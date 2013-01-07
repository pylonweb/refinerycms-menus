module Support
	class CreateSupportResource < ActiveRecord::Migration
	  def self.up
	  	unless self.table_exists?(:support_resource)
		    create_table :support_resource do |t|
		      t.string :title
		      t.boolean :draft
		    end
		  end

		  unless self.table_exists?(:support_another_resource)
		    create_table :support_another_resource do |t|
		      t.string :title
		      t.boolean :draft
		    end
		  end
	  end
	end
end
