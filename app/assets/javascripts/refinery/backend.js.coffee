jQuery =>
	$('#sortable_list, .sortable_list').addClass("reordering")
	list_reorder.sortable_list.nestedSortable("enable")
	
	$('#sortable_list').on 'click', '.header', ->
		$(this).siblings('.body').slideToggle()

	$('form').submit (e) ->
		save_structure($(this))

	$('#save_structure').click (e) ->
		e.preventDefault()
		save_structure($('form'))

save_structure = (form) ->
	alert("hej")
	list_reorder.sortable_list.nestedSortable("disable")

	$('#sortable_list, .sortable_list').removeClass("reordering")

	if list_reorder.update_url != null
		
		# lists = list_reorder.sortable_list.nestedSortable('toArray')

		# serialized_lists = {}
		# $.each lists, (index, value) ->
		# 	serialized_lists[value.item_id] = value

		serialized_lists = list_reorder.sortable_list.serializelist()

		serialized_data = form.serialize() + serialized_lists

		for elem in serialized_lists.split('&')
			if elem.length
				input = $("<input>").attr("type", "hidden").attr("name", elem.split('=')[0]).val(elem.split('=')[1])
				form.append(input)

		return true

		# $.post $('form').attr('action'), form.serialize()

		# $.post $('form').attr('action'), serialized_data, (data, status, jqXHR)->
		# 	console.log(jqXHR)
		# 	# window.location = '/users/login';

		# $.post $('form').attr('action'), form.serialize(), ->
		# 	$.post list_reorder.update_url, list_reorder.sortable_list.serializelist()
