require "spec_helper"

module Refinery
  module Menus
    module Admin
      describe "Pages" do
        login_refinery_user
        
        context "when no menus" do
          context "index" do 
            it "invites to add one" do
              visit refinery.menus_admin_menus_path
              page.should have_content(::I18n.t('no_items_yet', :scope => 'refinery.menus.admin.menus.records'))
            end
          end
        end

        context "when an menu exists" do
          let!(:menu) { FactoryGirl.create(:menu) }

          context "index" do 
            it "lists all menus" do
              visit refinery.menus_admin_menus_path

              page.should have_content(menu.title)
            end
          end

          context "edit/update" do
            it "updates menu" do
              visit refinery.menus_admin_menus_path

              page.should have_selector("a[href='#{refinery.edit_menus_admin_menu_path(menu)}']")

              click_link ::I18n.t('edit', :scope => 'refinery.menus.admin.menus.menu')

              fill_in "Title", :with => "Updated Menu"
              click_button "Save"

              page.should have_content("'Updated Menu' was successfully updated.")

              within "#records" do
                page.should have_content("Updated Menu")
              end
            end

            describe "custom links" do
              it "adds new custom link", :js do
                visit refinery.edit_menus_admin_menu_path(menu)

                fill_in "menu_link_custom_url", with: "http://google.dk" 
                fill_in "menu_link_label", with: "Google" 

                click_button (::I18n.t('add', :scope => 'refinery.menus.admin.menu_links.custom_link'))

                within "#links-container" do
                  page.should have_content("Google")
                end
              end

              it "adds new custom link without label", :js do
                visit refinery.edit_menus_admin_menu_path(menu)

                fill_in "menu_link_custom_url", with: "http://google.dk" 

                click_button (::I18n.t('add', :scope => 'refinery.menus.admin.menu_links.custom_link'))
                
                within "#links-container" do
                  page.should have_content("Google")
                end
              end
            end

            describe "resource links" do
              it "adds new resource link", :js
            end

            context "when no links" do
              it "invites to add one" do
                visit refinery.edit_menus_admin_menu_path(menu)
                page.should have_content(::I18n.t('no_links', :scope => 'refinery.menus.admin.menus.form'))
              end

              it "removes help text when link is added", :js do
                visit refinery.edit_menus_admin_menu_path(menu)
                click_button (::I18n.t('add', :scope => 'refinery.menus.admin.menu_links.custom_link'))

                page.should_not have_content(::I18n.t('no_links', :scope => 'refinery.menus.admin.menus.form'))
              end
            end


            context "when links" do
              let!(:link_1) { menu.links.create(:label => 'Link 1') }
              let!(:link_2) { menu.links.create(:label => 'Link 2') }
              before { menu.reload }

              it "lists all links" do
                visit refinery.edit_menus_admin_menu_path(menu)

                page.should have_content(link_1.label)
                page.should have_content(link_2.label)
              end

              it "destroys links with js", :js do
                visit refinery.edit_menus_admin_menu_path(menu)

                page.should have_content(link_1.label)

                within "#menu_link_#{link_1.id}" do 
                  click_link "remove"
                end

                page.should_not have_content(link_1.label)
              end

            end

            context "when nested links exists" do
              let!(:company_link) { menu.links.create(:label => 'Our Company') }
              let!(:team_link) { menu.links.create(:label => 'Our Team', parent_id: company_link.id) }
              let!(:locations_link) { menu.links.create :label => 'Our Locations', parent_id: team_link.id }
              let!(:location_link) { menu.links.create :label => 'New York', parent_id: locations_link.id }
              let!(:about_link) { menu.links.create :label => 'About' }
              before { menu.reload }


              it "shows correct nested tree" do
                visit refinery.edit_menus_admin_menu_path(menu)

                page.should have_content(company_link.label)

                within "#menu_link_#{company_link.id}" do    
                  page.should have_content(team_link.label)

                  within "#menu_link_#{team_link.id}" do    
                    page.should_not have_content(company_link.label)

                    page.should have_content(locations_link.label)

                    within "#menu_link_#{locations_link.id}" do    
                      page.should_not have_content(company_link.label)
                      page.should_not have_content(team_link.label)

                      page.should have_content(location_link.label)
                    end
                  end
                end
              end

              it "enables user to change structure"
              it "saves new structure when updated"

              # TODO: Do not work, error in drag and drop
              # context "test" do
              #   it "DRAG AND DROP TEST", :js do
              #     visit refinery.edit_menus_admin_menu_path(menu)

              #     within "#menu_link_#{team_link.id}" do
              #       page.should_not have_content(about_link.label) 
              #     end

              #     group = find("#menu_link_#{team_link.id} ul.nested:first-child")
              #     item = find("#menu_link_#{about_link.id}")

              #     item.drag_to group

              #     within "#menu_link_#{team_link.id}" do
              #       page.should have_content(about_link.label) 
              #     end

              #   end
              # end

            end
          end
        end
      end
    end
  end
end