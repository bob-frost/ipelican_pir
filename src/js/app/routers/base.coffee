class App.Routers.Base extends Backbone.Router

  routes:
    '*path' : 'notFound'

  current: { name: null, fragment: null, args: [] }
  previous: { name: null, fragment: null, args: [] }

  initialize: (options) ->
    @route /^\!\/(ru|en)\/?$/, 'home'
    @route /^\!\/(ru|en)\/select\/(.+)\/?$/, 'home'
    @route /^\!\/(ru|en)\/companies\/?$/, 'companies'
    @route /^\!\/(ru|en)\/companies\/(.+)\/?$/, 'company'
    @route /^\!\/(ru|en)\/companies\/page\/(\d+)\/?$/, 'companies'
    @route /^\!\/(ru|en)\/companies\/(name|activity_types|brands|equipment_types)\/(.+)\/?$/, 'searchCompanies'
    @route /^\!\/(ru|en)\/companies\/(name|activity_types|brands|equipment_types)\/(.+)\/page\/(\d+)\/?$/, 'searchCompanies'

  before: (name, fragment, args) ->
    if @current
      @previous = @current
    @current =
      name: name
      fragment: fragment
      args: args

    App.setLocale args[0]

  after: (name, args) ->
