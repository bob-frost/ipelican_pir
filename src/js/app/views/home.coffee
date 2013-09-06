class App.Views.Home extends App.Views.Abstract

  id: 'home'

  events: 
    'click #business-area' : '_showBusinessAreaTooltip'

  initialize: ->
    @mapMarkers = {}

  render: ->
    @$el.html(JST['home'])

    @$map = $('#map')
    @$businessArea = $('#business-area')

    view = @
    @$map.mapster
      highlight: false
      fillColor: 'f08d83'
      singleSelect: true
      mapKey: 'title'
      showToolTip: false
      onClick: (e) ->
        view._showHiddenMarkers()
        if e.selected
          view.setMapTooltip(e.key)
        else
          view.unsetMapTooltip()
    @

  search: (attr, value) ->
    @clearMap()
    view = @
    companies = App.companies.search(attr, value)
    _.each companies, (company) ->
      view.setMapMarker company.get('id')
    @_updateSearchSummary attr, value, companies.length
      
  clearMap: ->
    if App.router.previous.name
      $('area').mapster('deselect')
      @unsetMapMarkers()
      @unsetMapTooltip()

  setMapMarker: (key) ->
    view = @
    if areaProp = @_calculateMapAreaWrapper(key)
      if !@mapMarkers[key]
        areaProp['z-index'] = areaProp.top + areaProp.height
        $marker = $("<div class='map-marker-wrapper' title='#{key}'><div></div></div>")
        $marker.css areaProp
        $marker.on 'click', (e) ->
          $('area').mapster('deselect')
          if view._markerIsVisible(key)
            view.setMapTooltip key
            view._hideMarker key
          else
            view.unsetMapTooltip()

        @$el.append($marker)
        @mapMarkers[key] = $marker
      @mapMarkers[key].show()

  unsetMapMarker: (key) ->
    if $marker = @mapMarkers[key]
      $marker.remove()
    delete @mapMarkers[key]

  unsetMapMarkers: ->
    view = @
    _.each @mapMarkers, (marker, key) ->
      view.unsetMapMarker key

  setMapTooltip: (key) ->
    @unsetMapTooltip()
    company = App.companies.get(key)
    if company
      @_displayTooltip JST['mapCompanyTooltip'](company: company), @_calculateMapAreaWrapper(key)

  unsetMapTooltip: ->
    @_showHiddenMarkers()
    if @$mapTooltip
      @$mapTooltip.remove()
      @$mapTooltip = null

  selectMapArea: (key) ->
    if $area = @_getMapArea(key)
      $area.mapster 'select'
      @setMapTooltip key

  _calculateMapAreaCoords: (key) ->
    key = key.toString()
    if $area = @_getMapArea(key)
      if !STANDS[key].boundingBox
        rawCoords = _.map $area.attr('coords').split(','), (v) ->
          parseInt v
        minX = 9999
        maxX = 0
        minY = 9999
        maxY = 0
        i = 0
        while i < rawCoords.length
          minX = rawCoords[i] if rawCoords[i] < minX
          maxX = rawCoords[i] if rawCoords[i] > maxX
          minY = rawCoords[i+1] if rawCoords[i+1] < minY
          maxY = rawCoords[i+1] if rawCoords[i+1] > maxY
          i += 2
        STANDS[key].boundingBox = {'minX': minX, 'maxX': maxX, 'minY': minY, 'maxY': maxY}
      STANDS[key].boundingBox

    else
      null

  _calculateMapAreaWrapper: (key) ->
    if coords = @_calculateMapAreaCoords(key)
      width  = coords.maxX - coords.minX
      height = coords.maxY - coords.minY
      left   = coords.minX + 20 # #main el left padding
      top    = coords.minY + 80 # #main el top padding
      {'width': width, 'height': height, 'left': left, 'top': top}
    else
      null

  _getMapArea: (key) ->
    if STANDS[key]
      $("area[title='#{key}']").first()
    else
      null

  _showHiddenMarkers: ->
    $('.map-marker-wrapper div').show()

  _markerIsVisible: (key) ->
    @mapMarkers[key] && $('div', @mapMarkers[key]).is(':visible')

  _hideMarker: (key) ->
    if $marker = @mapMarkers[key]
      $('div', $marker).hide()

  _updateSearchSummary: (attr, value, count) ->
    App.baseView.updateSearchSummary attr, value, count

  _displayTooltip: (content, areaProp) ->
    @unsetMapTooltip()

    view = @

    areaProp.top = areaProp.height * 0.4 + areaProp.top
    areaProp.height = 0
    @$mapTooltip = $(JST['mapTooltip'](content: content))
    @$mapTooltip.css(areaProp)
    $el = @$mapTooltip
    @$mapTooltip.imagesLoaded().always ->
      $innerEl = $('.map-tooltip', $el)
      
      horiz = areaProp.width / 2 + areaProp.left
      if horiz > 920
        $innerEl.addClass 'rev-horiz'
      vert = areaProp.top + $('#header').outerHeight() - $innerEl.outerHeight()
      if vert < 30
        $innerEl.addClass 'rev-vert'
        $el.css 'top', areaProp.height * 0.6 + areaProp.top
      $el.removeClass 'hidden'

    $('.close', @$mapTooltip).on 'click', (e) ->
      $('area').mapster 'deselect'
      view.unsetMapTooltip()
    @$el.append @$mapTooltip

  _showBusinessAreaTooltip: (e) ->
    if $('#business-area-tooltip').length
      @unsetMapTooltip()
    else
      areaProp = {}
      areaProp.width  = @$businessArea.width()
      areaProp.height = @$businessArea.height()
      areaProp.left   = parseInt @$businessArea.css('left').replace('px', '')
      areaProp.top    = parseInt @$businessArea.css('top').replace('px', '')
      $('area').mapster 'deselect'
      @_displayTooltip JST['mapBusinessAreaTooltip'](), areaProp
      @$mapTooltip.attr('id', 'business-area-tooltip')
       