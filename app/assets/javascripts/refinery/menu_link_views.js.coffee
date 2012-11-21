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
        @hidden_fields() +
        @form() +
        "<a class='remove'>Remove</a>" +
      "</div>" +
    "</div>"

  hidden_fields: =>
    ViewHelpers.hidden_field('id', @attributes.id) +
    ViewHelpers.hidden_field('deleted', false)

  remove: =>
    @deleted = true
    @el.find('input.deleted-field').val('true')
    @el.fadeOut()



class CustomMenuLink extends MenuLink

  type_name: =>
    "Custom Link"

  form: =>
    ViewHelpers.text_field_tag('custom_url', @attributes.custom_url) +
    ViewHelpers.text_field_tag('label', @attributes.label) +
    ViewHelpers.text_field_tag('title_attribute', @attributes.title_attribute)



class ResourceMenuLink extends MenuLink

  constructor: (attr) ->
    super(attr)
    @attributes.label ||= @type_name()

  form: =>
    ViewHelpers.hidden_field('refinery_resource_id', @attributes.refinery_resource_id) +
    ViewHelpers.hidden_field('refinery_resource_type', @attributes.refinery_resource_type) +
    ViewHelpers.text_field_tag('label', @attributes.label) +
    ViewHelpers.text_field_tag('title_attribute', @attributes.title_attribute)

  type_name: =>
    @attributes.refinery_resource_type.titleize()


window.CustomMenuLink = CustomMenuLink
window.ResourceMenuLink = ResourceMenuLink