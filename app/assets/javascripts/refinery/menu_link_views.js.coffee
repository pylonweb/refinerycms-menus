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
    "<li class='pp-link record' id='" + @dom_id() + "'>" +
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
    "</li>"
    
  dom_id: =>
    'page_position_' + (@attributes.id || "")

  hidden_fields: =>
    ViewHelpers.hidden_field('id', @attributes.id) +
    ViewHelpers.hidden_field('_destroy', false)

  remove: =>
    @deleted = true
    @el.fadeOut =>
      if @attributes.id
        # persisted - set 'delete' field to true
        @el.find('input._destroy-field').val('true')
      else
        # not persisted yet - just remove this view from form
        @el.remove()


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
    ViewHelpers.text_field_tag('title_attribute', @attributes.title_attribute) +
    "<div class='field'><label>Original</label>" +
    "<div class='original-resource'>#{@attributes.resource.title}</div></div>"


  type_name: =>
    @attributes.refinery_resource_type.titleize()


window.CustomMenuLink = CustomMenuLink
window.ResourceMenuLink = ResourceMenuLink