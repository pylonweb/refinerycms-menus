class MenuLink

  constructor: (attr) ->
    @attributes = attr
    @attributes.title_attribute ||= ""

    @new_record = @attributes.new_record || false
    @id = @attributes.id
    @el = $(@render())
    @$body = @el.find('.body')
    # @el.find('.header').click =>
    #   @$body.slideToggle()
    @el.find('a.remove').click(@remove)
    @deleted = false
    if @attributes.parent_id
      @parent = $("#page_position_#{@attributes.parent_id}") 

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
      "<ul class='nested'></ul>" +
    "</li>"
    
  dom_id: =>
    'page_position_' + (@id || "" )

  hidden_fields: =>
    unless @new_record
      ViewHelpers.hidden_field('id', @id, @id) +
      ViewHelpers.hidden_field('_destroy', @id, false)

  remove: =>
    @deleted = true
    @el.fadeOut =>
      if @new_record
        # not persisted yet - just remove this view from form
        @el.remove()
      else
        # persisted - set 'delete' field to true
        @el.removeAttr('id').find('input._destroy-field').val('true')



class CustomMenuLink extends MenuLink

  type_name: =>
    "Custom Link"

  form: =>
    ViewHelpers.text_field_tag('custom_url', @id, @attributes.custom_url) +
    ViewHelpers.text_field_tag('label', @id, @attributes.label) +
    ViewHelpers.text_field_tag('title_attribute', @id, @attributes.title_attribute)



class ResourceMenuLink extends MenuLink

  constructor: (attr) ->
    super(attr)
    @attributes.label ||= @type_name()

  form: =>
    ViewHelpers.hidden_field('refinery_resource_id', @id, @attributes.refinery_resource_id) +
    ViewHelpers.hidden_field('refinery_resource_type', @id, @attributes.refinery_resource_type) +
    ViewHelpers.text_field_tag('label', @id, @attributes.label) +
    ViewHelpers.text_field_tag('title_attribute', @id, @attributes.title_attribute) +
    "<div class='field'><label>Original</label>" +
    "<div class='original-resource'>#{@attributes.resource.title}</div></div>"


  type_name: =>
    @attributes.refinery_resource_type.titleize()


window.CustomMenuLink = CustomMenuLink
window.ResourceMenuLink = ResourceMenuLink