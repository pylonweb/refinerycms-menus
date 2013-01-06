require "spec_helper"

module Refinery
  describe PageMenu do

    describe "validations" do
      it "should be valid with unique title and permatitle" do
        FactoryGirl.build(:page_menu, title: "New Menu", permatitle: "new_menu")
        FactoryGirl.build(:page_menu).should be_valid
      end

      it "should require a title" do
        FactoryGirl.build(:page_menu, title: "").should_not be_valid
      end

      it "should require a unique title" do
        FactoryGirl.create(:page_menu, title: "First Menu", permatitle: 'first-menu')
        FactoryGirl.build(:page_menu, title: "First Menu", permatitle: 'second-menu').should_not be_valid
      end

      it "should require a permatitle" do
        FactoryGirl.build(:page_menu, permatitle: "").should_not be_valid
      end

      it "should require a unique permatitle" do
        FactoryGirl.create(:page_menu, title: "First Menu", permatitle: 'first-menu')
        FactoryGirl.build(:page_menu, title: "Second Menu", permatitle: 'first-menu').should_not be_valid
      end
    end

    describe "#links_attributes=" do
      before(:each) do
        @page_menu = FactoryGirl.create(:page_menu)
        @menu_link = FactoryGirl.create(:menu_link, menu: @page_menu)
      end

      it "does nothing when empty array passed" do
        @page_menu.links_attributes = []
        @page_menu.save
        @page_menu.links.count.should == 1
      end

      it "creates a new position when no id is specified" do
        @page_menu.links_attributes = [{:custom_url => "/myurl"}]
        @page_menu.save
        @page_menu.links.count.should == 2
        @page_menu.links.last.custom_url.should == "/myurl"
      end

      it "deletes a position when :_destroy is set to true" do
        @page_menu.reload # needs to see the position
        @page_menu.links_attributes = [{id: @menu_link.id, _destroy: true}]
        @page_menu.save
        @page_menu.links.count.should == 0
      end

    end

    describe "#roots" do
      before(:each) do
        @page_menu = FactoryGirl.create(:page_menu)
        @menu_link_parent = FactoryGirl.create(:menu_link, menu: @page_menu)
        @menu_link_child = FactoryGirl.create(:menu_link, menu: @page_menu, parent_id: @menu_link_parent.id)
      end

      it "should returns all parents" do
        @page_menu.reload
        @page_menu.roots.should include(@menu_link_parent)
      end

      it "should not return childs" do
        @page_menu.reload
        @page_menu.links.should include(@menu_link_child, @menu_link_parent)
        @page_menu.roots.should_not include(@menu_link_child)
      end

    end

  end
end