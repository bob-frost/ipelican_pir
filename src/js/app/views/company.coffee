class App.Views.Company extends App.Views.Abstract

  id: 'company'

  render: ->
    stands = _.pluck App.companies.where(name: @model.get('name')), 'id'
    @$el.html(JST['company'](company: @model, stands: stands))
    @

  setCompany: (company) ->
    @model = company

