jQuery =>
	$('#form-container').css('min-height', $('#left_actions').height() + "px")

	$('#sortable_list, .sortable_list').addClass("reordering")
	list_reorder.sortable_list.nestedSortable("enable")

	$('#sortable_list').on 'click', '.header', ->
		$(this).siblings('.body').slideToggle()

	$('#page_menu_form').submit (e) ->
		save_structure($(this))

save_structure = (form) ->
	list_reorder.sortable_list.nestedSortable("disable")

	$('#sortable_list, .sortable_list').removeClass("reordering")

	if list_reorder.update_url != null
		serialized_lists = list_reorder.sortable_list.serializelist()

		for elem in serialized_lists.split('&')
			if elem.length
				input = $("<input>").attr("type", "hidden").attr("name", elem.split('=')[0]).val(elem.split('=')[1])
				form.append(input)