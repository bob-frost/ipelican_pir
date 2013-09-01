class App.Views.Home extends App.Views.Abstract

  id: 'home'

  render: (options = {}) ->
    @$el.html(JST['home'])

    @map = $('#map')
    map = @map
    map.mapster
      highlight: false
      fillColor: 'f08d83'
      singleSelect: true
      mapKey: 'title'
      showToolTip: false
      toolTipClose: []
      onClick: (e) ->
        map.mapster('tooltip')
        if e.selected
          company = App.companies.get(e.key)
          if company
            map.mapster 'set_options',
              areas: [
                key: e.key
                toolTip: company.get('name')
              ]
            map.mapster('tooltip', e.key)

    @

