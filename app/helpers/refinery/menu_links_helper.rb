module Refinery
  module MenuLinksHelper
    require 'nokogiri'

    def render_menu_list(menu_links)
      results = "".html_safe
      menu_links.each do |menu_link|
        if menu_link.custom_link?
          results << render_custom_menu_link(menu_link)
        else
          results << render_resource_menu_link(menu_link)
        end
      end
      results
    end

    def render_custom_menu_link(menu_link)
      list_partial = render(partial: "custom_menu_link", locals: {menu_link: menu_link})

      dom = Nokogiri::HTML.fragment(list_partial)
      li = dom.css('li').first

      # append nested ul to end of this li
      li << nested_ul(menu_link)

      dom.to_s.html_safe
    end

    def render_resource_menu_link(menu_link)
      list_partial = render(:partial => menu_link.resource_config[:admin_partial], :collection => [menu_link.resource])

      dom = Nokogiri::HTML.fragment(list_partial)
      li = dom.css('li').first

      # change li's id to that of the page_partial
      li['id'] = dom_id(menu_link)

      # wrap inside of li in div if it's not already
      if dom.css('li > div').empty?
        div = Nokogiri.make("<div class='clearfix'></div>")
        div.children = li.children
        li.children = div
      end

      # edit title to show actual link label as well
      title_div = dom.css('.title').first
      if title_div.present?
        title_div.content = menu_link.label
      end

      # append nested ul to end of this li
      li << nested_ul(menu_link)

      dom.to_s.html_safe
    end

    def nested_ul(menu_link)
      # recursively create nested list of children
      content_tag :ul, class: 'nested' do
        render_menu_list(menu_link.children)
      end
    end


  end
end