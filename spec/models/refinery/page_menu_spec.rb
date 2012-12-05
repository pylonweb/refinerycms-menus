require "spec_helper"

module Refinery
  describe PageMenu do
    let(:page_menu) { FactoryGirl.create(:page_menu) }

    describe "validations" do
      it "should require a title" do
        FactoryGirl.build(:page_menu, title: "").should_not be_valid
      end

      it "should require a permatitle" do
        FactoryGirl.build(:page_menu, permatitle: "").should_not be_valid
      end
    end

  end
end