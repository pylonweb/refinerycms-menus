require "spec_helper"

ActiveRecord::Schema.define do
  create_table :support_resource, :force => true do |t|
    t.string :title
    t.boolean :draft, default: false
  end

  create_table :support_another_resource, :force => true do |t|
    t.string :title
    t.boolean :draft, default: false
  end
end

module Refinery
  module Menus
    class LinkResource < ActiveRecord::Base
      self.table_name = :support_resource
      attr_accessible  :title, :draft
      scope :live, where(draft: false)
    end

    class AnotherLinkResource < ActiveRecord::Base
      self.table_name = :support_another_resource
      attr_accessible  :title, :draft
    end
  end
end

module Refinery
  module Menus
    describe MenuLink do

      describe "validations" do
        it "should be valid with menu and label" do
          @menu = FactoryGirl.build(:menu)
          FactoryGirl.build(:menu_link, menu: @menu, label: "Home").should be_valid
        end

        it "should require a menu" do
          FactoryGirl.build(:menu_link, menu: nil).should_not be_valid
        end

        it "should require a label" do
          FactoryGirl.build(:menu_link, label: "").should_not be_valid
        end
      end

      describe "callbacks" do
        it "should call set_label before validations" do
          @menu = MenuLink.new
          @menu.should_receive(:set_label)

          @menu.valid?
        end
      end

      describe 'html attributes' do
        before { Refinery::Menus.html_attributes = true }

        %w(title class id).each do |attribute|
          it "makes the #{attribute}_attribute attribute available to Refinery MenuItems" do
            ml = MenuLink.new
            ml.send("#{attribute}_attribute=".to_sym, 'the_test_val')
            m = Refinery::MenuItem.new(ml.to_refinery_menu_item)
            m[:html][attribute].should eq('the_test_val')
          end
        end
      end

      describe ".find_all_of_type" do
        before(:each) do
          @resource_puplished = Refinery::Menus::LinkResource.create!
          @resource_draft = Refinery::Menus::LinkResource.create!(draft: true)
          @another_resource = Refinery::Menus::AnotherLinkResource.create

          Refinery::Menus::MenuLink.stub(:resource_klass).with(:refinery_resource).and_return(Refinery::Menus::LinkResource)
        end

        it "should return all of chosen type" do
          Refinery::Menus::MenuLink.stub(:resource_config).with(:refinery_resource).and_return(Hash.new)

          Refinery::Menus::MenuLink.find_all_of_type(:refinery_resource).should include(@resource_puplished, @resource_draft)
        end

        it "should not return other records" do
          Refinery::Menus::MenuLink.stub(:resource_config).with(:refinery_resource).and_return(Hash.new)

          Refinery::Menus::MenuLink.find_all_of_type(:refinery_resource).should_not include(@another_resource)
        end

        it "should apply scope from symbol if present" do
          Refinery::Menus::MenuLink.stub(:resource_config).with(:refinery_resource).and_return(:scope => :live)
          
          Refinery::Menus::MenuLink.find_all_of_type(:refinery_resource).should_not include(@resource_draft)
          Refinery::Menus::MenuLink.find_all_of_type(:refinery_resource).should include(@resource_puplished)
        end

        it "should apply scope from a block if present" do
          Refinery::Menus::MenuLink.stub(:resource_config).with(:refinery_resource).and_return(scope: Proc.new { where(draft: false) })
          
          Refinery::Menus::MenuLink.find_all_of_type(:refinery_resource).should_not include(@resource_draft)
          Refinery::Menus::MenuLink.find_all_of_type(:refinery_resource).should include(@resource_puplished)
        end
      end

      describe ".resource_klass" do
        before(:all) do
          @configuration = {
            klass: 'Refinery::Menus::LinkResource',
            title_attr: 'title',
          }

          Refinery::Menus::MenuLink.stub(:resource_config).with(:refinery_resource).and_return(@configuration)
          Refinery::Menus::MenuLink.stub(:resource_config).with(:refinery_another_resource).and_return(nil)
        end

        it "should return a class object of input type" do
          Refinery::Menus::MenuLink.resource_klass(:refinery_resource).should == Refinery::Menus::LinkResource
        end

        it "should return a error if class is not in configuration" do
          expect{ Refinery::Menus::MenuLink.resource_klass(:refinery_another_resource) }.to raise_error(NoMethodError)
        end
      end

      describe ".resource_config" do
        before(:each) do
          @configuration = {
            refinery_resource: {
              klass: 'Refinery::Menus::LinkResource',
              title_attr: 'title',
            }
          }

          Refinery::Menus.menu_resources = @configuration
        end

        it "should return a hash with all configuration for type" do
          Refinery::Menus::MenuLink.resource_config(:refinery_resource).should == @configuration[:refinery_resource]
        end
      end

      describe "#set_label" do

        it "should not change label if already set" do
          @menu_link = FactoryGirl.build(:menu_link, label: "a label")
          @menu_link.set_label
          @menu_link.label.should == "a label"
        end

        it "excpects label to change to host name if custom_link" do
          @menu_link = FactoryGirl.build(:menu_link, label: nil, custom_url: "http://google.dk")
          expect{ @menu_link.set_label }.to change { @menu_link.label }.from(nil).to("Google")
        end

        it "expects label to change to url if custom_link and wrong url" do
          @menu_link = FactoryGirl.build(:menu_link, label: nil, custom_url: "http://google")
          expect{ @menu_link.set_label }.to change { @menu_link.label }.from(nil).to("http://google")
        end

        it "should set label to resource title if resource link" do
          @menu_link = FactoryGirl.build(:menu_link, label: nil, resource_id: 1, resource_type: "refinery_resource")
          @resource = double(:send => "Some Resource", :title => "Some Resource")
          @menu_link.stub(:resource).and_return(@resource)
          @menu_link.stub(:resource_config).and_return({:title_attr => "title"})
          @menu_link.stub(:custom_link?).and_return(false)

          expect{ @menu_link.set_label }.to change { @menu_link.label }.from(nil).to(@resource.title)
        end
      end

      describe "#resource_klass" do
        it "should call class method resource_klass" do
          Refinery::Menus::MenuLink.should_receive(:resource_klass).with("refinery_resource")
          @menu_link = FactoryGirl.build(:menu_link, resource_type: "refinery_resource")

          @menu_link.resource_klass
        end
      end

      describe "#resource_config" do
        it "should call class method resource_config" do
          Refinery::Menus::MenuLink.should_receive(:resource_config).with("refinery_resource")
          @menu_link = FactoryGirl.build(:menu_link, resource_type: "refinery_resource")

          @menu_link.resource_config
        end
      end

      describe "#resource_type" do
        it "should return resource_type if exists" do
          @menu_link = FactoryGirl.build(:menu_link, resource_type: "refinery_resource")
          @menu_link.resource_type.should == "refinery_resource"
        end

        it 'should return "Custom link" if it is a custom link' do
          @menu_link = FactoryGirl.build(:menu_link)
          @menu_link.resource_type.should == "Custom link"
        end
      end

      describe "#type_name" do
        it "should return titlelized version" do
          @menu_link = FactoryGirl.build(:menu_link)
          @menu_link.stub(:resource_type).and_return("some resource title")
          @menu_link.type_name.should == "some resource title".titleize
        end

      end

      describe "#custom_link?" do
        it "should return true if resource_id is nil" do
          @menu_link = FactoryGirl.build(:menu_link, resource_id: nil)
          @menu_link.custom_link?.should be_true
        end

        it "should return true if resource_type is nil" do
          @menu_link = FactoryGirl.build(:menu_link, resource_type: nil)
          @menu_link.custom_link?.should be_true
        end

        it "should return false if resource_id and resource_type is present" do
          @menu_link = FactoryGirl.build(:menu_link, resource_type: "refinery_resource", resource_id: 1)
          @menu_link.custom_link?.should be_false
        end
      end

      describe "#resource_link?" do
        it "should return false if resource_id is nil" do
          @menu_link = FactoryGirl.build(:menu_link, resource_id: nil)
          @menu_link.resource_link?.should be_false
        end

        it "should return false if resource_type is nil" do
          @menu_link = FactoryGirl.build(:menu_link, resource_type: nil)
          @menu_link.resource_link?.should be_false
        end

        it "should return true if resource_id and resource_type is present" do
          @menu_link = FactoryGirl.build(:menu_link, resource_type: "refinery_resource", resource_id: 1)
          @menu_link.resource_link?.should be_true
        end
      end

      describe "#resource" do
        before(:each) do
          @menu_link = FactoryGirl.build(:menu_link)
        end

        it "should return nil if custom_link" do
          @menu_link.stub(:custom_link?).and_return(true)
          @menu_link.resource.should be_nil
        end

        it "should return a resource if not custom_link" do
          @menu_link.stub(:custom_link?).and_return(false)
          @menu_link.stub(:resource_klass).and_return(Refinery::Menus::LinkResource)
          @resource = double("support_resource")
          Refinery::Menus::LinkResource.stub(:find).and_return(@resource)

          @menu_link.resource.should be(@resource)
        end
      end

      describe "#resouce_title" do
        it "should send title attribute to resource" do
          @resource = double("refinery_resource", title: "A title")
          @menu_link = FactoryGirl.build(:menu_link)
          @menu_link.stub(:resource).and_return(@resource)
          @menu_link.stub(:resource_config).and_return({:title_attr => "title"})

          @resource.should_receive(:title)
          @menu_link.resource_title.should == "A title"
        end
      end

      describe "#title" do
        it "should return title_attribute if present" do
          @menu_link = FactoryGirl.build(:menu_link, title_attribute: "Title")

          @menu_link.title.should == "Title"
        end

        it "should return label if title_attribute is nil" do
          @menu_link = FactoryGirl.build(:menu_link, title_attribute: nil)

          @menu_link.title.should == @menu_link.label
        end
      end

      describe "#resource_url" do
        before(:each) do
          @menu_link = FactoryGirl.build(:menu_link)
        end

        it "should send url to resource if present" do
          @resource = double("refinery_resource", url: "http://google.dk")
          @menu_link.stub(:resource).and_return(@resource)

          @resource.should_receive(:url)
          @menu_link.resource_url.should == "http://google.dk"
        end

        it "should return '/' if resource is nil" do
          @menu_link.stub(:resource).and_return(nil)

          @menu_link.resource_url.should == '/'
        end
      end

      describe "#url" do
        before(:each) do
          @menu_link = FactoryGirl.build(:menu_link)
        end

        it "should call custom_url if custom link" do
          @menu_link.stub(:custom_link?).and_return(true)

          @menu_link.should_receive(:custom_url)
          @menu_link.url
        end

        it "should call resource_url if not custom link" do
          @menu_link.stub(:custom_link?).and_return(false)

          @menu_link.should_receive(:resource_url)
          @menu_link.url
        end
      end

      describe "#as_json" do
        before(:each) do
          @menu_link = FactoryGirl.build(:menu_link)
        end

        it "should include resource title if resource link" do
          @menu_link.stub(:resource_link?).and_return(true)
          @menu_link.should_receive(:resource_title).and_return("A title")

          @menu_link.as_json[:resource].should == {:title=>"A title"}
        end

        it "should not include resource title if not resource link" do
          @menu_link.stub(:resource_link?).and_return(false)

          @menu_link.as_json[:resource].should be_nil
        end
      end

      describe "#to_refinery_menu_item" do
        let(:menu_link) do
          Refinery::Menus::MenuLink.new(
            :parent_id => 8,
            :custom_url => "http://google.dk"

          # MenuLink does not allow setting lft and rgt, so stub them.
          ).tap do |p|
            p[:id] = 5
            p[:lft] = 6
            p[:rgt] = 7
            p[:menu_match] = "^/foo$"
          end
        end

        subject { menu_link.to_refinery_menu_item }

        shared_examples_for("Refinery menu item hash") do
          [ [:id, 5],
            [:lft, 6],
            [:rgt, 7],
            [:parent_id, 8],
            [:menu_match, "^/foo$"]
          ].each do |attr, value|
            it "returns the correct :#{attr}" do
              subject[attr].should eq(value)
            end
          end

          it "returns the correct :url" do
            subject[:url].should eq(menu_link.url)
          end
        end

        context "with #title" do
          before do
            menu_link[:label] = "Menu Title"
          end

          it_should_behave_like "Refinery menu item hash"

          it "returns the menu_title for :title" do
            subject[:title].should eq("Menu Title")
          end
        end

        context "with #html" do
          before do
            menu_link[:title_attribute] = "Title"
          end

          it_should_behave_like "Refinery menu item hash"

          it "returns the title for :title" do
            subject[:html][:title].should eq("Title")
          end
        end

      end

    end
  end
end