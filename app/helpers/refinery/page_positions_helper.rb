module Refinery
  module PagePositionsHelper
    require 'nokogiri'

    def render_menu_list(page_positions)
      results = "".html_safe
      page_positions.each do |page_position|
        if page_position.custom_link?
          results << render_custom_menu_link(page_position)
        else
          results << render_resource_menu_link(page_position)
        end
      end
      results
    end

    def render_custom_menu_link(page_position)
      list_partial = render(partial: "custom_page_position", locals: {page_position: page_position})

      dom = Nokogiri::HTML.fragment(list_partial)
      li = dom.css('li').first

      # append nested ul to end of this li
      li << nested_ul(page_position)

      dom.to_s.html_safe
    end

    def render_resource_menu_link(page_position)
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

      # edit title to show actual link label as well
      title_div = dom.css('.title').first
      if title_div.present?
        title_div.content = "#{page_position.label} | #{title_div.content}"
      end

      # append nested ul to end of this li
      li << nested_ul(page_position)

      dom.to_s.html_safe
    end

    def nested_ul(page_position)
      # recursively create nested list of children
      content_tag :ul, class: 'nested' do
        render_menu_list(page_position.children)
      end
    end


  end
end