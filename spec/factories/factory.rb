FactoryGirl.define do
	factory :menu, :class => Refinery::Menus::Menu do
		sequence(:title) { |n| "Menu #{n}" }
		sequence(:permatitle) {|n| "menu_#{n}" }
	end

	factory :menu_link, aliases: [:link], :class => Refinery::Menus::MenuLink do
		menu
		label "label"
		
		factory :menu_link_with_resource do
			resource_id 1
			resource_type 'refinery_resource'
		end
	end
end