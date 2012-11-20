module Refinery
  module PagePositionsHelper
    require 'nokogiri'

    def render_menu_list(page_positions)
      results = "".html_safe
      page_positions.each do |page_position|
        list_partial = render(:partial => page_position.resource_config[:admin_partial], :collection => [page_position.resource])

        dom = Nokogiri::HTML.fragment(list_partial)
        li = dom.css('li').first

        # change li's id to that of the page_partial
        li['id'] = dom_id(page_position)

        # wrap inside of li in div if it's not already
        if dom.css('li > div').empty?
          div = Nokogiri.make("<div class='clearfix'></div>")
          div.children = li.children
          li.children = div
        end

        # recursively create nested list of children
        nested_ul = content_tag :ul, class: 'nested' do
          render_menu_list(page_position.children)
        end

        # append nested ul to end of this li
        li << nested_ul

        results << dom.to_s.html_safe
      end
      results
    end


  end
end