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
    @_updateNavElements([@searchButtons, @backToMap])

  showHome: -> 
    unless @homeView
      if @currentView 
        @currentView.hide() 
      @homeView = new App.Views.Home
      @main.append @homeView.el
      @homeView.render()
      @currentView = @homeView
    else
      @homeView.clearMap()
      @_showView @homeView

    $('body').attr('class', 'bg')
    @_updateNavElements([@languageBar, @searchButtons])

  showCompanies: (locale, page) -> 
    @_showCompanies page

    $('body').attr('class', '')
    @_updateNavElements([@searchButtons, @backToMap])

  searchCompanies: (locale, attr, value, page) ->
    @_showCompanies page, attr, value

    $('body').attr('class', '')

    $form = $("#search-form-#{attr}")
    $form.find('select, input').first().val(value)
    @_updateNavElements([@clearSearch, $form])

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
    @_updateNavElements([@searchButtons, @backToMap])

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
    @_updateNavElements([@clearSearch, $("#search-form-#{$caller.data('type')}")])

  _clearSearchForm: (event) ->
    $('.search-form input, .search-form select').val('')
    if App.router.current == 'searchCompanies'
      App.router.navigate "#!/#{App.getLocale()}/companies", true
    else
      navEl = [@searchButtons]
      if App.router.current == 'home'
        @homeView.clearMap()
        navEl.push(@languageBar)
      else
        navEl.push(@backToMap)
      @_updateNavElements(navEl)

  _submitSearchForm: (event) ->
    $caller = $(event.target)
    $form = $caller.closest('.search-form')
    attr = $form.attr('id').replace('search-form-', '')
    val = $.trim($form.find('select, input').first().val())
    if val.length > 0
      if App.router.current == 'home' && attr != 'name'
        @homeView.search attr, val
      else
        App.router.navigate "#!/#{App.getLocale()}/companies/#{attr}/#{val}", true

  _updateNavElements: (elmsToDisplay) ->
    $('.nav-el').not(elmsToDisplay).hide()
    _.each elmsToDisplay, (el) ->
      el.show()