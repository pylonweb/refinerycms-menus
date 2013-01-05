# View Helpers

class ViewHelpers

  text_field_tag: (name, id, value="") =>
    "<div class='field'>" +
      "<label>#{name.titleize()}</label>" +
      @input_tag(name, id, value, 'text') +
    "</div>"

  hidden_field: (name, id, value="") =>
    @input_tag(name, id, value, 'hidden')

  input_tag: (name, id, value, type) =>
    "<input type='#{type}' value='#{@parse_value(value)}' name='#{@name_for_attr(name, id)}' class='#{name}-field' />"

  parse_value: (val) =>
    if (typeof val == "string") then val.escapeQuotes() else val

  name_for_attr: (name, id) =>
    "page_menu[positions_attributes][#{id}][#{name}]"



window.ViewHelpers = new ViewHelpers


# Random things
#   think we could get underscore in here?

String.prototype.titleize = ->
  words = this.split('_')
  for word, i in words
    words[i] = word.capitalize()
  words.join(' ')

String.prototype.capitalize = ->
  this.charAt(0).toUpperCase() + this.substring(1).toLowerCase();

String.prototype.escapeQuotes = ->
  str = this.replace(/'/g, "&#39;")
  str.replace(/"/g, "&quot;")