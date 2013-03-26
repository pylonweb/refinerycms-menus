module Refinery
  module Menus
    module Admin
      class MenuLinksController < Refinery::AdminController

        def create
          respond_to do |format|
            format.js do
              @menu_links = []
              if params[:resource_ids]
                params[:resource_ids].each do |id|
                  @menu_links << MenuLink.create({resource_id: id}.merge(params[:menu_link]))
                end
              else
                @menu_links << MenuLink.create(params[:menu_link])
              end
            end
          end
        end

        def destroy
          respond_to do |format|
            format.js do
              @menu_link = MenuLink.find(params[:id])
              @menu_link.destroy
            end
          end
        end

      end
    end
  end
end