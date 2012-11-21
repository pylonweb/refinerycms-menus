class CustomMenuLink

  constructor: (url, label, title_attribute) ->
    @url = url
    @label = label
    @title_attribute = title_attribute || ""
    @el = $(@render())
    @el.find('.header').click =>
      @el.find('.body').slideToggle()

  type_name: =>
    "Custom Link"

  render: =>
    "<div class='pp-link'>" +
      "<div class='header'>" +
        "<div class='name'>#{@label}</div>" +
        "<div class='type'>#{@type_name()}</div>" +
        "<span class='arrow'>&nbsp;</span>" +
      "</div>" +
      "<div class='body'>" +
        ViewHelpers.input_tag('url', @url) +
        ViewHelpers.input_tag('label', @label) +
        ViewHelpers.input_tag('title_attribute', @title_attribute) +
      "</div>" +
    "</div>"

window.CustomMenuLink = CustomMenuLink