jQuery =>
  $('#form-container').css('min-height', $('#left_actions').height() + "px")

  sortable_list = create_sortable_list(
    update_url: null
    sortable_list: $('#sortable_list')
    tree: true
    replaceContentsAfterUpdate: false
  )

  sortable_list.enable_reordering()

  $('#sortable_list').on 'click', '.header', ->
    $(this).siblings('.body').slideToggle()

  $('#menu_form').submit (e) ->
    save_structure($(this))

  reset_custom_link_form()

reset_link_forms = () ->
  reset_custom_link_form()
  reset_resource_link_forms()

reset_custom_link_form = () ->
  $('#menu_link_custom_url').val('http://')
  $('#menu_link_label').val('')

reset_resource_link_forms = () ->
  $('.resource-pp-add-box').find('input[type="checkbox"]').attr('checked', false)

save_structure = (form) ->
  sortable_list.disable_reordering()

  serialized_lists = sortable_list.serializelist()
  for elem in serialized_lists.split('&')
    if elem.length
      input = $("<input>").attr("type", "hidden").attr("name", elem.split('=')[0]).val(elem.split('=')[1])
      form.append(input)

window.reset_link_forms = reset_link_forms
