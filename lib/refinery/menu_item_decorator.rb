module Refinery
  class MenuItem
    class_eval %{
      attr_accessor :html
    } unless self.respond_to?(:html)
  end
end
    
