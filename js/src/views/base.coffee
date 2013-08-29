class App.Views.Base extends Backbone.View
  
  events: 
    'click #search-buttons .btn' : '_showSearchForm'
    'click #clear-search' : '_clearSearchForm'
    'click .search-form .btn' : '_submitSearchForm'

  initialize: (options) ->
    @header = $('#header')
    @main = $('#main')
    @render()

    App.on('change:locale', @render)
    App.router.on("route:notFound", @notFound, @)
    App.router.on("route:home", @showHome, @)
    App.router.on("route:companies", @showCompanies, @)
    App.router.on("route:searchCompanies", @searchCompanies, @)
    App.router.on("route:company", @showCompany, @)

  render: =>
    @header.html(JST['header'])
    @searchForms = $('.search-form')
    @searchButtons = $('#search-buttons')
    @languageBar = $('#language-bar')
    @backToMap = $('#back-to-map')
    @clearSearch = $('#clear-search')

  notFound: ->
    @main.html('not found')
    $('body').attr('class', 'bg')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.show()

  showHome: -> 
    @main.html('map')
    $('body').attr('class', 'bg')
    @languageBar.show()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.hide()

  showCompanies: -> 
    @main.html('companies')
    $('body').attr('class', '')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.show()

  searchCompanies: (locale, attribute, value) ->
    @main.html("search companies by #{attribute} - #{value}")
    $('body').attr('class', '')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.show()
    @searchButtons.hide()
    @backToMap.hide()
    $form = $("#search-form-#{attribute}")
    $form.show().find('select, input').first().val(value)

  showCompany: (locale, id) -> 
    @main.html("company #{id}")
    $('body').attr('class', '')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.show()

  _showSearchForm: (event) ->
    $caller = $(event.target)
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.show()
    @searchButtons.hide()
    @backToMap.hide()
    $("#search-form-#{$caller.data('type')}").show()

  _clearSearchForm: (event) ->
    @searchForms.hide().find('input, select').val('')
    @clearSearch.hide()
    @searchButtons.show()
    if App.router.current == 'home'
      @languageBar.show()
    else
      @backToMap.show()

  _submitSearchForm: (event) ->
    $caller = $(event.target)
    $form = $caller.closest('.search-form')
    val = $.trim($form.find('select, input').first().val())
    if val.length > 0
      navigate "#!/#{App.getLocale()}/companies/#{$form.attr('id').replace('search-form-', '')}/#{val}"