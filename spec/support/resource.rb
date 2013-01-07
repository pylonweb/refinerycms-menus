module Support
	class Resource < ActiveRecord::Base
		self.table_name = :support_resource
		attr_accessible  :title, :draft
	end
end

module Support
	class AnotherResource < ActiveRecord::Base
		self.table_name = :support_another_resource
		attr_accessible  :title, :draft
	end
end