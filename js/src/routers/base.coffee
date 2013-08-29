class App.Routers.Base extends Backbone.Router

  routes:
    '*path' : 'notFound'

  current: null

  initialize: (options) ->
    @route /^\!\/(ru|en)\/?$/, 'home'
    @route /^\!\/(ru|en)\/companies\/?$/, 'companies'
    @route /^\!\/(ru|en)\/companies\/(.+)\/?$/, 'company'

  before: (name, args) ->
    @current = name
    App.setLocale args[0]

  after: (name, args) ->
