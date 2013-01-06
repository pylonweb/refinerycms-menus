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

    describe "#positions_attributes=" do
      before(:each) do
        @page_menu = FactoryGirl.create(:page_menu)
        @page_position = FactoryGirl.create(:page_position, menu: @page_menu)
      end

      it "does nothing when empty array passed" do
        @page_menu.positions_attributes = []
        @page_menu.save
        @page_menu.positions.count.should == 1
      end

      it "creates a new position when no id is specified" do
        @page_menu.positions_attributes = [{:custom_url => "/myurl"}]
        @page_menu.save
        @page_menu.positions.count.should == 2
        @page_menu.positions.last.custom_url.should == "/myurl"
      end

      it "deletes a position when :_destroy is set to true" do
        @page_menu.reload # needs to see the position
        @page_menu.positions_attributes = [{id: @page_position.id, _destroy: true}]
        @page_menu.save
        @page_menu.positions.count.should == 0
      end

    end

    describe "#roots" do
      before(:each) do
        @page_menu = FactoryGirl.create(:page_menu)
        @page_position_parent = FactoryGirl.create(:page_position, menu: @page_menu)
        @page_position_child = FactoryGirl.create(:page_position, menu: @page_menu, parent_id: @page_position_parent.id)
      end

      it "should returns all parents" do
        @page_menu.reload
        @page_menu.roots.should include(@page_position_parent)
      end

      it "should not return childs" do
        @page_menu.reload
        @page_menu.positions.should include(@page_position_child, @page_position_parent)
        @page_menu.roots.should_not include(@page_position_child)
      end

    end

  end
end