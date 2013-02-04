FactoryGirl.define do
	factory :menu, :class => Refinery::Menus::Menu do
		sequence(:title) { |n| "Menu #{n}" }
		sequence(:permatitle) {|n| "menu_#{n}" }
	end

	factory :menu_link, aliases: [:link], :class => Refinery::Menus::MenuLink do
		menu
		label "label"
		
		factory :menu_link_with_resource do
			refinery_resource_id 1
			refinery_resource_type 'refinery_resource'
		end
	end
end