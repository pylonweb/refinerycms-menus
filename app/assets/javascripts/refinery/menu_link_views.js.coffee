class MenuLink

  constructor: (opts) ->
    @title_attribute = opts.title_attribute || ""
    @id = opts.id || null

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

  constructor: (opts) ->
    @url = opts.custom_url
    @label = opts.label
    super(opts)

  type_name: =>
    "Custom Link"

  form: =>
    ViewHelpers.input_tag('url', @url) +
    ViewHelpers.input_tag('label', @label) +
    ViewHelpers.input_tag('title_attribute', @title_attribute)



class ResourceMenuLink extends MenuLink

  constructor: (opts) ->
    @resource_id = opts.resource_id
    @resource_type = opts.resource_type
    @label = opts.label || resource_type.titleize()
    super(opts)

  form: =>
    ViewHelpers.input_tag('label', @label) +
    ViewHelpers.input_tag('title_attribute', @title_attribute)

  type_name: =>
    @resource_type.titleize()


window.CustomMenuLink = CustomMenuLink
window.ResourceMenuLink = ResourceMenuLink