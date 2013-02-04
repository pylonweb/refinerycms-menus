require "spec_helper"

module Refinery
  module Menus
    describe Menu do

      describe "validations" do
        it "should be valid with unique title and permatitle" do
          FactoryGirl.build(:menu, title: "New Menu", permatitle: "new_menu")
          FactoryGirl.build(:menu).should be_valid
        end

        it "should require a title" do
          FactoryGirl.build(:menu, title: "").should_not be_valid
        end

        it "should require a unique title" do
          FactoryGirl.create(:menu, title: "First Menu", permatitle: 'first-menu')
          FactoryGirl.build(:menu, title: "First Menu", permatitle: 'second-menu').should_not be_valid
        end

        it "should require a permatitle" do
          FactoryGirl.build(:menu, permatitle: "").should_not be_valid
        end

        it "should require a unique permatitle" do
          FactoryGirl.create(:menu, title: "First Menu", permatitle: 'first-menu')
          FactoryGirl.build(:menu, title: "Second Menu", permatitle: 'first-menu').should_not be_valid
        end
      end

      describe "#links_attributes=" do
        before(:each) do
          @menu = FactoryGirl.create(:menu)
          @menu_link = FactoryGirl.create(:menu_link, menu: @menu)
        end

        it "does nothing when empty array passed" do
          @menu.links_attributes = []
          @menu.save
          @menu.links.count.should == 1
        end

        it "creates a new position when no id is specified" do
          @menu.links_attributes = [{:custom_url => "/myurl"}]
          @menu.save
          @menu.links.count.should == 2
          @menu.links.last.custom_url.should == "/myurl"
        end

        it "deletes a position when :_destroy is set to true" do
          @menu.reload # needs to see the position
          @menu.links_attributes = [{id: @menu_link.id, _destroy: true}]
          @menu.save
          @menu.links.count.should == 0
        end

      end

      describe "#roots" do
        before(:each) do
          @menu = FactoryGirl.create(:menu)
          @menu_link_parent = FactoryGirl.create(:menu_link, menu: @menu)
          @menu_link_child = FactoryGirl.create(:menu_link, menu: @menu, parent_id: @menu_link_parent.id)
        end

        it "should returns all parents" do
          @menu.reload
          @menu.roots.should include(@menu_link_parent)
        end

        it "should not return childs" do
          @menu.reload
          @menu.links.should include(@menu_link_child, @menu_link_parent)
          @menu.roots.should_not include(@menu_link_child)
        end

      end

    end
  end
end