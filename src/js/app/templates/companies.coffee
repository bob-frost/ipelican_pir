window.JST['companies'] = _.template(
  "
  <div id='companies-list'>
    <% if(prevPage){ %>
      <a href='<%= prevPage %>' id='prev-page'><span></span></a>
    <% } %>
    <% if(nextPage){ %>
      <a href='<%= nextPage %>' id='next-page'><span></span></a>
    <% } %>
    <% var lastLetter = null %>
    <% _.each(columns, function(column){ %>
      <div class='column'>
        <% _.each(column, function(group, letter){ %>
          <div class='group'>
            <% if(letter != lastLetter){ %>
              <div class='caption'><%= letter %></div>
              <% lastLetter = letter; %>
            <% } %>
            <ul>
              <% _.each(group, function(company){ %>
                <% link = App.baseView.searchType != 'companies' ? ('select/' + company.get('id')) : ('companies/' + company.get('id')) %>
                <li><a href='#!/<%= App.getLocale() %>/<%= link %>'><%= company.get('name') %></a></li>
              <% }); %>
            </ul>
            <div class='clr'></div>
          </div>
        <% }); %>
      </div>
    <% }); %>
    <div class='clr'></div>
    <% if(App.baseView.searchType != 'companies'){ %>
      <br />
      <a href='#!/<%= App.getLocale() %>/companies' class='btn'><%= I18n.t('go_to_companies') %></a>
    <% } %>
  </div>
  
  "
)