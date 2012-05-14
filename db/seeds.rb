if defined?(::Refinery::User)
  ::Refinery::User.all.each do |user|
    if user.plugins.where(:name => 'refinery_page_menus').blank?
      user.plugins.create(:name => 'refinery_page_menus',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

# if defined?(::Refinery::PageMenu)
#   ::Refinery::PageMenus.default_menus.each do |menu|
#     ::Refinery::PageMenu.create(:title => menu.titleize, :permatitle => menu)
#   end
# end
