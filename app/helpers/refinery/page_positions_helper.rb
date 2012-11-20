module Refinery
  module PagePositionsHelper

    def render_menu_list(page_positions)
      results = "".html_safe
      page_positions.each do |page_position|
        li = render(:partial => page_position.resource_config[:admin_partial], :collection => [page_position.resource])
        nested_ul = content_tag :ul, class: 'nested' do
          render_menu_list(page_position.children)
        end
        # append nested ul to end of this li
        li = li.sub(/<\/li>/, nested_ul + "</li>".html_safe).html_safe
        results << li
      end
      results
    end

  end
end