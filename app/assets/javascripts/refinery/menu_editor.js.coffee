#= require ./helpers
#= require ./menu_link_views

###########
# EDITORS #
###########

class NewCustomLinkEditor

  constructor: ->
    @$container = $('#custom_url_box')
    @$container.find('a.add_link').click(@new_link)
    @$url_field = @$container.find('input[name=url]')
    @$label_field = @$container.find('input[name=label]')

  new_link: =>
    url = @$url_field.val()
    label = @$label_field.val()
    if url && label
      link_view = new CustomMenuLink(url, label)
      menuLinkIndex.append(link_view)
    return false


##############
# INDEX VIEW #
##############

class MenuLinkIndex

  constructor: ->
    @$container = $('#links_container')

  append: (link_view) =>
    @$container.find('.placeholder-text').remove()
    @$container.append(link_view.el)


$('document').ready ->
  new NewCustomLinkEditor
  window.menuLinkIndex = new MenuLinkIndex



