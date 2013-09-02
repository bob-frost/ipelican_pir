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
          view._setMapTooltip(e.key)
        else
          view._unsetMapTooltip()
    @

  search: (attr, value) ->
    @clearMap()
    view = @
    companies = App.companies.search(attr, value)
    _.each companies, (company) ->
      view._setMapMarker company.get('id')
    @_updateSearchSummary attr, value, companies.length
      
  clearMap: ->
    $('area').mapster('deselect')
    @_unsetMapMarkers()
    @_unsetMapTooltip()

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

  _setMapMarker: (key) ->
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
            view._setMapTooltip key
          else
            view._unsetMapTooltip()
            view._showHiddenMarkers()

        @$el.append($marker)
        @mapMarkers[key] = $marker
      @mapMarkers[key].show()

  _unsetMapMarker: (key) ->
    if $marker = @mapMarkers[key]
      $marker.remove()
    delete @mapMarkers[key]

  _unsetMapMarkers: ->
    view = @
    _.each @mapMarkers, (marker, key) ->
      view._unsetMapMarker key

  _showHiddenMarkers: ->
    $('.map-marker-wrapper div').show()

  _setMapTooltip: (key) ->
    @_unsetMapTooltip()
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
        view._unsetMapTooltip()
        view._showHiddenMarkers()
      @$el.append @$mapTooltip

  _unsetMapTooltip: ->
    if @$mapTooltip
      @$mapTooltip.remove()

  _updateSearchSummary: (attr, value, count) ->
    App.baseView.updateSearchSummary attr, value, count
   