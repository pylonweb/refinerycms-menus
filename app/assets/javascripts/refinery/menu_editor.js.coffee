#= require ./helpers
#= require ./menu_link_views

###########
# EDITORS #
###########

class NewLinkEditor

  constructor: (el) ->
    @$container = el
    @$container.find('a.add_link').click(@new_link)

class NewCustomLinkEditor extends NewLinkEditor

  constructor: (el) ->
    super
    @$url_field = @$container.find('input[name=url]')
    @$label_field = @$container.find('input[name=label]')

  new_link: =>
    url = @$url_field.val()
    label = @$label_field.val()
    if url && label
      link_view = new CustomMenuLink(url, label)
      menuLinkIndex.append(link_view)
    return false

class NewResourceLinkEditor extends NewLinkEditor

  constructor: (el) ->
    super

  new_link: =>
    $checked_inputs = @$container.find('input:checked')
    ids = []
    $checked_inputs.each ->
      ids.push $(this).val()
    console.log ids
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
  new NewCustomLinkEditor($('#custom_url_box'))
  $('.resource-pp-add-box').each ->
    resource_type = $(this).data('type')
    new NewResourceLinkEditor($(this))

  window.menuLinkIndex = new MenuLinkIndex



