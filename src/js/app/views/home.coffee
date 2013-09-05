class App.Views.Home extends App.Views.Abstract

  id: 'home'

  initialize: ->
    @mapMarkers = {}

  render: ->
    @$el.html(JST['home'])

    @map = $('#map')
    map = @map
    view = @
    @map.mapster
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
          if $('div', $(this)).is(':visible')
            view._showHiddenMarkers()
            $('div', $(this)).hide()
            view.setMapTooltip key
          else
            view.unsetMapTooltip()
            view._showHiddenMarkers()

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
    view = @
    company = App.companies.get(key)
    if company
      areaProp = @_calculateMapAreaWrapper(key)
      areaProp.top = areaProp.top + areaProp.height * 0.4
      areaProp.height = 0
      @$mapTooltip = $(JST['mapTooltip'](company: company))
      @$mapTooltip.css(areaProp)
      $('.close', @$mapTooltip).on 'click', (e) ->
        $('area').mapster('deselect')
        view.unsetMapTooltip()
        view._showHiddenMarkers()
      @$el.append @$mapTooltip

  unsetMapTooltip: ->
    if @$mapTooltip
      @$mapTooltip.remove()

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

  _updateSearchSummary: (attr, value, count) ->
    App.baseView.updateSearchSummary attr, value, count
   