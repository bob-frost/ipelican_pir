class App.Views.Base extends Backbone.View
  
  events: 
    'click #search-buttons .btn' : '_showSearchForm'
    'click #clear-search' : '_clearSearchForm'
    'click .search-form .btn' : '_submitSearchForm'

  initialize: (options) ->
    @$main = $('#main')
    @searchType = null
    @render()

    App.on('change:locale', @render)
    App.router.on("route:notFound", @notFound, @)
    App.router.on("route:home", @showHome, @)
    App.router.on("route:searchHome", @searchHome, @)
    App.router.on("route:companies", @showCompanies, @)
    App.router.on("route:searchCompanies", @searchCompanies, @)
    App.router.on("route:company", @showCompany, @)

  render: =>
    if @$header
      $('select', @$header).each ->
        $(this).select2 'destroy'
    @$header = $('#header')
    @$header.html(JST['header'])

    $('select', @$header).select2
      width: 692
      containerCssClass: 'large'
      dropdownCssClass: 'large'

    @$searchButtons = $('#search-buttons')
    @$languageBar = $('#language-bar')
    @$backToMap = $('#back-to-map')
    @$backToCompanies = $('#back-to-companies')
    @$clearSearch = $('#clear-search')
    @$searchSummary = $('#search-summary')
    
    $('body').removeClass('loading')
    _.each App.locales, (locale) ->
      $('body').removeClass(locale)
    $('body').addClass(App.getLocale())

  notFound: ->
    unless @notFoundView 
      @notFoundView = new App.Views.NotFound
      @$main.append @notFoundView.hide().render().el
    @_showView @notFoundView

    $('body').removeClass('bg')
    @_updateNavElements([@$searchButtons, @$backToMap])

  showHome: (locale, preselect) -> 
    @searchType = 'home'

    @_showHome()
    
    if preselect
      @homeView.selectMapArea preselect

    $('body').addClass('bg')
    @_updateNavElements([@$languageBar, @$searchButtons])

  searchHome: (locale, attr, value) -> 
    @searchType = 'home'
   
    @_showHome()
    @homeView.search attr, value

    $('body').addClass('bg')
    @_updateNavElements([@$clearSearch, @$searchSummary])

  showCompanies: (locale, page) -> 
    @searchType = 'companies'

    @_showCompanies page

    $('body').removeClass('bg')
    @_updateNavElements([@$searchButtons, @$backToMap])

    $form = $("#search-form-#{attr}")
    $("select.search-field[name='#{attr}'], input.search-field[name='#{attr}']").val(value).change()

  searchCompanies: (locale, attr, value, page) ->
    @_showCompanies page, attr, value

    $('body').removeClass('bg')
    @_updateNavElements([@$clearSearch, @$searchSummary])

    $form = $("#search-form-#{attr}")
    $("select.search-field[name='#{attr}'], input.search-field[name='#{attr}']").val(value).change()

  showCompany: (locale, id) ->
    company = App.companies.get(id)
    unless company
      @notFound()
      return
    unless @companyView 
      @companyView = new App.Views.Company
      @$main.append @companyView.hide().el
    @companyView.setCompany(company)
    @_showView @companyView.render()

    $('body').removeClass('bg')
    navEl = [@$searchButtons]
    if App.router.previous.name == 'companies' || App.router.previous.name == 'searchCompanies'
      navEl.push @$backToCompanies
    else
      navEl.push @$backToMap
    @_updateNavElements navEl
    if App.router.previous.name == 'companies' || App.router.previous.name == 'searchCompanies'
      @$backToCompanies.attr('href', "##{App.router.previous.fragment}")
    else if App.router.previous.name == 'searchHome'
      @$backToMap.attr('href', "##{App.router.previous.fragment}")
    else
      @$backToMap.attr('href', "#!/#{App.getLocale()}/select/#{company.id}")

  updateSearchSummary: (attr, value, count) ->
    $('.title', @$searchSummary).text "#{I18n.t "search.result_titles.#{attr}"} - #{value}"
    $('.count', @$searchSummary).text I18n.t('search.result_stands', {count: count})

  _showView: (view) ->
    if @currentView 
      @currentView.hide()
    @currentView = view.show()

  _showHome: ->
    unless @homeView
      if @currentView
        @currentView.hide()
      @homeView = new App.Views.Home
      @$main.append @homeView.el
      @homeView.render()
      @currentView = @homeView
    else
      @homeView.clearMap()
      @_showView @homeView

  _showCompanies: ->
    unless @companiesView 
      @companiesView = new App.Views.Companies({collection: App.companies})
      @$main.append @companiesView.hide().el
    @_showView @companiesView.render.apply(@companiesView, arguments) 

  _showSearchForm: (event) ->
    $caller = $(event.target)
    @_updateNavElements([@$clearSearch, $("#search-form-#{$caller.data('type')}")])

  _clearSearchForm: (event) ->
    $('select.search-field, input.search-field').val('').change()
    if App.router.current.name == 'home' || App.router.current.name == 'companies'
      @_updateNavElements([@$languageBar, @$searchButtons])
    else if @searchType == 'companies' && App.router.current.name == 'searchCompanies'
      App.router.navigate "#!/#{App.getLocale()}/companies", true
    else
      App.router.navigate "#!/#{App.getLocale()}", true

  _submitSearchForm: (event) ->
    $caller = $(event.target)
    $form = $caller.closest('.search-form')
    $field = $('select.search-field, input.search-field', $form).first()
    attr = $field.attr('name')
    val = $.trim($field.val())
    if val.length > 0
      if attr == 'name'
        if App.router.current.name == 'home' || App.router.current.name == 'searchHome'
          @searchType = 'home'
        App.router.navigate "#!/#{App.getLocale()}/companies/#{attr}/#{val}", true
      else
        if @searchType == 'companies'
          App.router.navigate "#!/#{App.getLocale()}/companies/#{attr}/#{val}", true
        else
          App.router.navigate "#!/#{App.getLocale()}/#{attr}/#{val}", true

  _updateNavElements: (elmsToDisplay) ->
    $('.nav-el').not(elmsToDisplay).hide()
    _.each elmsToDisplay, (el) ->
      el.show()
    @$backToMap.attr('href', "#!/#{App.getLocale()}")
    @$backToCompanies.attr('href', "#!/#{App.getLocale()}/companies")