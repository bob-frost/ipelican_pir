class App.Views.Base extends Backbone.View

  initialize: (options) ->
    @header = $('#header')
    @main = $('#main')
    @render()

    App.on('change:locale', @render)
    App.router.on("route:notFound", @notFound, @)
    App.router.on("route:home", @showHome, @)
    App.router.on("route:companies", @showCompanies, @)
    App.router.on("route:company", @showCompany, @)

  render: =>
    @header.html(JST['header'])
    @languageBar = $('#language-bar')
    @backToMap = $('#back-to-map')

  notFound: ->
    @main.html('not found')
    $('body').attr('class', 'bg')
    @languageBar.hide()
    @backToMap.show()

  showHome: -> 
    @main.html('map')
    $('body').attr('class', 'bg')
    @languageBar.show()
    @backToMap.hide()

  showCompanies: -> 
    @main.html('companies')
    $('body').attr('class', '')
    @languageBar.hide()
    @backToMap.show()

  showCompany: (locale, id) -> 
    @main.html("company #{id}")
    $('body').attr('class', '')
    @languageBar.hide()
    @backToMap.show()