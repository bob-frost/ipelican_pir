Backbone.Router::before = ->

Backbone.Router::after = ->

Backbone.Router::route = (route, name, callback) ->
  route = @_routeToRegExp(route)  unless _.isRegExp(route)
  if _.isFunction(name)
    callback = name
    name = ""
  callback = this[name]  unless callback
  router = this
  Backbone.history.route route, (fragment) ->
    args = router._extractParameters(route, fragment)
    router.before.apply router, [name, fragment, args]
    callback and callback.apply(router, args)
    router.after.apply router, [name, fragment, args]
    router.trigger.apply router, ["route:" + name].concat(args)
    router.trigger "route", name, args
    Backbone.history.trigger "route", router, name, args

  this
