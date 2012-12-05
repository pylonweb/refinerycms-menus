# View Helpers

class ViewHelpers

  text_field_tag: (name, value="") =>
    "<div class='field'>" +
      "<label>#{name.titleize()}</label>" +
      @input_tag(name, value, 'text') +
    "</div>"

  hidden_field: (name, value="") =>
    @input_tag(name, value, 'hidden')

  input_tag: (name, value, type) =>
    "<input type='#{type}' value='#{@parse_value(value)}' name='#{@name_for_attr(name)}' class='#{name}-field' />"

  parse_value: (val) =>
    if (typeof val == "string") then val.escapeQuotes() else val

  name_for_attr: (name) =>
    "page_menu[positions_attributes][][#{name}]"



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