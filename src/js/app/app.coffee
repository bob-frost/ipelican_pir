window.JST = {}

window.I18n ||= {}
window.I18n.locales = ['ru', 'en']
window.I18n.defaultLocale = 'ru'
window.I18n.fallbacks = true

window.App =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  locales: ['ru', 'en']
  defaultLocale: 'ru'
  locale: 'null'

  init: ->
    _.extend(@, Backbone.Events)
    unless (location.hash.substring(5, 6) == '/' || location.hash.substring(5, 6) == '') && @hasLocale(location.hash.substring(3, 5))
      location.hash = "#!/#{I18n.defaultLocale}"
    @setLocale location.hash.substring(3, 5)
    @router = new App.Routers.Base()
    @baseView = new App.Views.Base(el: $('#wrapper'))
    Backbone.history.start()

  hasLocale: (locale) ->
    locale in I18n.locales

  setLocale: (locale) ->
    if locale != @getLocale() && @hasLocale(locale)
      I18n.locale = locale
      @_loadData()
      @trigger('change:locale')

  getLocale: ->
    I18n.locale

  _loadData: ->
    @companies ||= new App.Collections.Companies
    @companies.reset DATA[@getLocale()]
    @activityTypes = _.uniq(_.flatten(@companies.pluck('activity_types'))).sort()
    @equipmentTypes = _.uniq(_.flatten(@companies.pluck('equipment_types'))).sort()
    @brands = _.uniq(_.flatten(@companies.pluck('brands'))).sort()

$ ->
  App.init()


