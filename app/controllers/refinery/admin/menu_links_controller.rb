module Refinery
  module Admin
    class MenuLinksController < Refinery::AdminController

      def create
        respond_to do |format|
          format.js do
            @menu_links = []
            if params[:refinery_resource_ids]
              params[:refinery_resource_ids].each do |id|
                @menu_links << MenuLink.create({refinery_resource_id: id}.merge(params[:menu_link]))
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