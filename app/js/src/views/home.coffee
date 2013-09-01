class App.Views.Home extends App.Views.Abstract

  id: 'home'

  render: (options = {}) ->
    @$el.html(I18n.t('map'))
    @

