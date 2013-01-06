require "spec_helper"

module Refinery
  describe PagePosition do

    describe "validations" do
      it "should be valid with title menu" do
        @page_menu = FactoryGirl.build(:page_menu)
        FactoryGirl.build(:page_position, menu: @page_menu).should be_valid
      end

      it "should require a menu" do
        FactoryGirl.build(:page_position, menu: nil).should_not be_valid
      end
    end

    describe ".find_all_of_type" do
      it "should return all of chosen type"
      it "should apply admin_page_filters if present"
    end

    describe ".resource_klass" do
      it "should return a class object of input type"
    end

    describe ".resource_config" do
      it "should return a hash with all configuration for type"
    end
   
    describe "#resource_klass" do
      it "should return a class object of instance type"
    end

    describe "#resource_config" do
      it "should return a hash with all configuration for the instance type"
    end
    

  end
end