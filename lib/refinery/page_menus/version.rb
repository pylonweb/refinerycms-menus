module Refinery
	module PageMenus
	  class Version
	    @major = 2
	    @minor = 0
	    @tiny  = 4
	    @build = 'dev'

	    class << self
	      attr_reader :major, :minor, :tiny, :build

	      def to_s
	        [@major, @minor, @tiny, @build].compact.join('.')
	      end
	    end
	  end
	end
end