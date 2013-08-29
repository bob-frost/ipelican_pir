class App.Routers.Base extends Backbone.Router

  routes:
    '*path' : 'notFound'

  current: null

  initialize: (options) ->
    @route /^\!\/(ru|en)\/?$/, 'home'
    @route /^\!\/(ru|en)\/companies\/?$/, 'companies'
    @route /^\!\/(ru|en)\/companies\/(.+)\/?$/, 'company'
    @route /^\!\/(ru|en)\/companies\/(name|activity-type|brand|equipment-type)\/(.+)\/?$/, 'searchCompanies'

  before: (name, args) ->
    @current = name
    App.setLocale args[0]

  after: (name, args) ->
