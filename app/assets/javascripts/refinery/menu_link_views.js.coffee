class MenuLink

  constructor: (attr) ->
    @attributes = attr
    @attributes.title_attribute ||= ""

    @el = $(@render())
    @$body = @el.find('.body')
    @el.find('.header').click =>
      @$body.slideToggle()
    @el.find('a.remove').click(@remove)
    @deleted = false

  render: =>
    "<div class='pp-link'>" +
      "<div class='header'>" +
        "<div class='name'>#{@attributes.label}</div>" +
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

  type_name: =>
    "Custom Link"

  form: =>
    ViewHelpers.input_tag('custom_url', @attributes.custom_url) +
    ViewHelpers.input_tag('label', @attributes.label) +
    ViewHelpers.input_tag('title_attribute', @attributes.title_attribute)



class ResourceMenuLink extends MenuLink

  constructor: (attr) ->
    super(attr)
    @attributes.label ||= @type_name()

  form: =>
    ViewHelpers.input_tag('label', @attributes.label) +
    ViewHelpers.input_tag('title_attribute', @attributes.title_attribute)

  type_name: =>
    @attributes.refinery_resource_type.titleize()


window.CustomMenuLink = CustomMenuLink
window.ResourceMenuLink = ResourceMenuLink