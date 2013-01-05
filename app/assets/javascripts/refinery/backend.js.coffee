jQuery =>
  $('#sortable_list, .sortable_list').addClass("reordering")
  list_reorder.sortable_list.nestedSortable("enable")
  
  $('.header').click ->
    $(this).siblings('.body').slideToggle()

  $('a.add_link').click ->
  	data = $.post($(this).data('url'))
  	alert(data)

  $('#form-container').css('min-height', $('#left_actions').height() + "px")
