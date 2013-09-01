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
    unless @notFoundView 
      @notFoundView = new App.Views.NotFound
      @main.append @notFoundView.hide().render().el
    @_showView @notFoundView

    $('body').attr('class', 'bg')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.show()

  showHome: -> 
    unless @homeView 
      @homeView = new App.Views.Home
      @main.append @homeView.hide().el
    @_showView @homeView.render()

    $('body').attr('class', 'bg')
    @languageBar.show()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.hide()

  showCompanies: (locale, page) -> 
    @_showCompanies page

    $('body').attr('class', '')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.show()

  searchCompanies: (locale, attr, value, page) ->
    @_showCompanies page, attr, value

    $('body').attr('class', '')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.show()
    @searchButtons.hide()
    @backToMap.hide()
    $form = $("#search-form-#{attr}")
    $form.show().find('select, input').first().val(value)

  showCompany: (locale, id) ->
    company = App.companies.get(id)
    unless company
      @notFound()
      return
    unless @companyView 
      @companyView = new App.Views.Company
      @main.append @companyView.hide().el
    @companyView.setCompany(company)
    @_showView @companyView.render()

    $('body').attr('class', '')
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.hide()
    @searchButtons.show()
    @backToMap.show()

  _showView: (view) ->
    if @currentView 
      @currentView.hide()
    @currentView = view.show()

  _showCompanies: ->
    unless @companiesView 
      @companiesView = new App.Views.Companies({collection: App.companies})
      @main.append @companiesView.hide().el
    @_showView @companiesView.render.apply(@companiesView, arguments) 

  _showSearchForm: (event) ->
    $caller = $(event.target)
    @languageBar.hide()
    @searchForms.hide()
    @clearSearch.show()
    @searchButtons.hide()
    @backToMap.hide()
    $("#search-form-#{$caller.data('type')}").show()

  _clearSearchForm: (event) ->
    $('input, select', @searchForms).val('')
    if App.router.current == 'searchCompanies'
      navigate "#!/#{App.getLocale()}/companies"
    else if App.router.current == 'searchMap' 
      navigate "#!/#{App.getLocale()}"
    else
      @searchForms.hide()
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