# View Helpers

class ViewHelpers

  input_tag: (name, value="") ->
    "<div class='field'>" +
      "<label>#{name.titleize()}</label>" +
      "<input type='text' value='#{value.escapeQuotes()}' />" +
    "</div>"

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