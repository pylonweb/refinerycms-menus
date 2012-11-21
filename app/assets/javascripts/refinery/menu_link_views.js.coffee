class MenuLink

  constructor: ->
    @el = $(@render())
    @$body = @el.find('.body')
    @el.find('.header').click =>
      @$body.slideToggle()
    @el.find('a.remove').click(@remove)
    @deleted = false

  render: =>
    "<div class='pp-link'>" +
      "<div class='header'>" +
        "<div class='name'>#{@label}</div>" +
        "<div class='type'>#{@type_name()}</div>" +
        "<span class='arrow'>&nbsp;</span>" +
      "</div>" +
      "<div class='body'>" +
        @form() +
        "<a class='remove'>Remove</a>" +
      "</div>" +
    "</div>"

  remove: =>
    @deleted = true
    @el.fadeOut()


class CustomMenuLink extends MenuLink

  constructor: (url, label, title_attribute) ->
    @url = url
    @label = label
    @title_attribute = title_attribute || ""
    super

  type_name: =>
    "Custom Link"

  form: =>
    ViewHelpers.input_tag('url', @url) +
    ViewHelpers.input_tag('label', @label) +
    ViewHelpers.input_tag('title_attribute', @title_attribute)



class ResourceMenuLink extends MenuLink

  constructor: (id, type, label, title_attribute) ->
    @id = id
    @type = type
    @label = label || type.titleize()
    @title_attribute = title_attribute || ""
    super

  form: =>
    ViewHelpers.input_tag('label', @label) +
    ViewHelpers.input_tag('title_attribute', @title_attribute)

  type_name: =>
    @type.titleize()


window.CustomMenuLink = CustomMenuLink
window.ResourceMenuLink = ResourceMenuLink