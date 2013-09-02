class App.Views.Companies extends App.Views.Abstract

  id: 'companies'

  render: (page, attr, value) ->
    companies = @collection.search(attr, value)
    total = companies.length
    page = parseInt(page)
    page = 1 unless page && page > 0
    per_page = 64
    start = (page - 1) * per_page
    end = start + per_page
    companies = companies.slice(start, end)

    columnsCount = 4
    columns = []
    columnLength = Math.ceil(companies.length / columnsCount)
    _.times columnsCount, ->
      column = companies.splice(0, columnLength)
      groups = {}
      _.each column, (company) ->
        letter = company.get("name").charAt(0).toUpperCase()
        groups[letter] or (groups[letter] = [])
        groups[letter].push company
      columns.push groups

    prevPage = if page > 1 then location.hash.replace(/\/page\/\d+/, '').replace(/\/$/, '') + "/page/#{page - 1}" else null
    nextPage = if end < total  then location.hash.replace(/\/page\/\d+/, '').replace(/\/$/, '') + "/page/#{page + 1}" else null

    @$el.html(JST['companies']({columns: columns, prevPage: prevPage, nextPage: nextPage}))

    @_updateSearchSummary attr, value, total
    
    @

  _updateSearchSummary: (attr, value, count) ->
    App.baseView.updateSearchSummary attr, value, count

