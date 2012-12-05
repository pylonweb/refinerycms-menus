FactoryGirl.define do
  factory :page_menu, :class => Refinery::PageMenu do
    sequence :title do |n|
      "Menu #{n}"
    end
    sequence :permatitle do |n|
      "my-page-title-#{n}"
    end
  end
end