module Refinery
  class MenuItem < HashWithIndifferentAccess

    class << self
      def attributes
        [:title, :parent_id, :lft, :rgt, :depth, :url, :menu, :menu_match, :html]
      end
    end

    class_eval %{
      def html
        @html ||= self[:html]
      end

      def html=(attr)
        @html = attr
      end
    } unless self.respond_to?(:html)

  end
end
    