#= require ./helpers
#= require ./menu_link_views

###########
# EDITORS #
###########

class NewLinkEditor

  constructor: (el) ->
    @$container = el
    @$container.find('a.add_link').click(@add_to_menu)

class NewCustomLinkEditor extends NewLinkEditor

  constructor: (el) ->
    super
    @$url_field = @$container.find('input[name=url]')
    @$label_field = @$container.find('input[name=label]')
    @refresh_inputs()

  add_to_menu: =>
    url = @$url_field.val()
    label = @$label_field.val()
    if url && label
      link_view = new CustomMenuLink({custom_url: url, label: label})
      menuLinkIndex.append(link_view)
      @refresh_inputs()
    return false

  refresh_inputs: =>
    @$url_field.val('http://')
    @$label_field.val('')


class NewResourceLinkEditor extends NewLinkEditor

  constructor: (el, type) ->
    super(el)
    @type = type

  add_to_menu: =>
    $checked_inputs = @$container.find('input:checked')
    ids = []
    $checked_inputs.each ->
      ids.push $(this).val()
    for id in ids
      @add_link(id)
    return false

  add_link: (id) =>
    label = @$container.find("input[value=#{id}]").siblings('label').first().text()
    link_view = new ResourceMenuLink({
      refinery_resource_id: id,
      refinery_resource_type: @type,
      label: label,
      resource : {
        title: label
      }
    })
    menuLinkIndex.append(link_view)
    @$container.find('input').removeAttr('checked');


##############
# INDEX VIEW #
##############

class MenuLinkIndex

  constructor: ->
    @$container = $('#sortable_list')
    # @populate_data(@$container.data('links'))

  append: (link_view) =>
    @$container.find('.placeholder-text').remove()
    @$container.append(link_view.el)

  populate_data: (links) =>
    for link in links
      if link.refinery_resource_id
        link_view = new ResourceMenuLink(link)
      else
        link_view = new CustomMenuLink(link)
      @append(link_view)




$('document').ready ->
  new NewCustomLinkEditor($('#custom_url_box'))
  $('.resource-pp-add-box').each ->
    resource_type = $(this).data('type')
    new NewResourceLinkEditor($(this), resource_type)

  window.menuLinkIndex = new MenuLinkIndex



