jQuery =>
  # $('#sortable_list, .sortable_list').addClass("reordering")
  # list_reorder.sortable_list.nestedSortable("enable")
  
  $('.header').click ->
    $(this).siblings('.body').slideToggle()