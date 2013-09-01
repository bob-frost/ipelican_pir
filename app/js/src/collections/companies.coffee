class App.Collections.Companies extends Backbone.Collection
  model: App.Models.Company

  comparator = (company) ->
    company.get 'name'

  search: (attr, value) ->
    return @models unless attr && value
    attr = attr.replace('-', '_')
    _.filter @models, (model) ->
      v = model.get(attr)
      if attr == 'name'
        v.toLowerCase().indexOf(value.toLowerCase()) != -1 
      else
        _.contains(v, value)
   
    
