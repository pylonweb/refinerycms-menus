require "spec_helper"

describe "manage page menus" do
  login_refinery_user

  before(:each) do
    @menu = FactoryGirl.create(:page_menu)
    @position = FactoryGirl.create(:menu_link, menu: @menu)
  end

  describe "update" do
    it "shows the menu item on the page", :js, :skip do
      visit refinery.edit_admin_page_menu_path(@menu)
      save_and_open_page
      find('#sortable_list').should have_css('.pp-link')
    end

  end

end