module Refinery
  module Admin
    class PagePositionsController < Refinery::AdminController

      crudify :'refinery/page_position',
              :order => "lft ASC",
              :include => [:children],
              :paging => false

    end
  end
end