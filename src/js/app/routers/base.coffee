class App.Routers.Base extends Backbone.Router

  routes:
    '*path' : 'notFound'

  current: null

  initialize: (options) ->
    @route /^\!\/(ru|en)\/?$/, 'home'
    @route /^\!\/(ru|en)\/select\/(.+)\/?$/, 'home'
    @route /^\!\/(ru|en)\/companies\/?$/, 'companies'
    @route /^\!\/(ru|en)\/companies\/(.+)\/?$/, 'company'
    @route /^\!\/(ru|en)\/companies\/page\/(\d+)\/?$/, 'companies'
    @route /^\!\/(ru|en)\/companies\/(name|activity_types|brands|equipment_types)\/(.+)\/?$/, 'searchCompanies'
    @route /^\!\/(ru|en)\/companies\/(name|activity_types|brands|equipment_types)\/(.+)\/page\/(\d+)\/?$/, 'searchCompanies'

  before: (name, args) ->
    @current = name
    App.setLocale args[0]

  after: (name, args) ->
