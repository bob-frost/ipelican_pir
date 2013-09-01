class App.Models.Company extends Backbone.Model

  defaults:
    id: null
    name: null
    description: null
    location: null
    phone: null
    site: null
    image: null
    brands: []
    equipment_types: []
    activity_types: []

  image: ->
    if @get('image') then "data/images/#{@get('image')}" else 'images/no-image.png'
 
  siteUrl: ->
    return null unless @get('site')
    if @get('site').indexOf('http') == 0 then @get('site') else "http://#{@get('site')}"

  siteName: ->
    return null unless @get('site')
    @get('site').replace(/^https?:\/\//, '').replace(/\/$/, '')

