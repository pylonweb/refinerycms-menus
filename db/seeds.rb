if defined?(::Refinery::User)
  ::Refinery::User.all.each do |user|
    if user.plugins.where(:name => 'refinery_menus').blank?
      user.plugins.create(:name => 'refinery_menus',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

Refinery::Menus.default_menus.each do |menu|
	Refinery::Menus::Menu.create(title: menu.titleize, permatitle: menu.underscore)
end
