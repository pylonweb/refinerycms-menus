module Refinery
  module Admin
    class PagePositionsController < Refinery::AdminController

      def create
        respond_to do |format|
          format.js do
            @page_positions = []
            if params[:refinery_resource_ids]
              params[:refinery_resource_ids].each do |id|
                @page_positions << PagePosition.create({refinery_resource_id: id}.merge(params[:page_position]))
              end
            else
              @page_positions << PagePosition.create(params[:page_position])
            end
          end
        end
      end

      def destroy
        respond_to do |format|
          format.js do
            @page_position = PagePosition.find(params[:id])
            @page_position.destroy
          end
        end
      end

    end
  end
end