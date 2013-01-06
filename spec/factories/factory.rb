FactoryGirl.define do
	factory :page_menu, aliases: [:menu], :class => Refinery::PageMenu do
		sequence :title do |n|
			"Menu #{n}"
		end
		sequence :permatitle do |n|
			"my-page-title-#{n}"
		end
	end

	factory :page_position, aliases: [:position], :class => Refinery::PagePosition do
		menu
	end
end