require "spec_helper"

module Refinery
  describe PageMenu do
    let(:page_menu) { FactoryGirl.create(:page_menu) }

    describe "validations" do
      it "should be valid with unique title and permatitle" do
        FactoryGirl.build(:page_menu)
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

  end
end