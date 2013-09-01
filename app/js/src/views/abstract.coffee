class App.Views.Abstract extends Backbone.View

  show: (callback) ->
    @$el.show()
    @

  hide: (callback) ->
    @$el.hide()
    @
