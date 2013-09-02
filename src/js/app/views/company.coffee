class App.Views.Company extends App.Views.Abstract

  id: 'company'

  render: ->
    @$el.html(JST['company'](company: @model))
    @

  setCompany: (company) ->
    @model = company

