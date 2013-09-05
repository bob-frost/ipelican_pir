class App.Views.NotFound extends App.Views.Abstract

  id: 'not-found'

  render: ->
    @$el.text I18n.t('page_not_found')
    @

