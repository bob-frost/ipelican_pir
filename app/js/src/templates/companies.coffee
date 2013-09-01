window.JST['companies'] = _.template(
  "
  <div id='companies-list'>
    <% if(prevPage){ %>
      <a href='<%= prevPage %>' id='prev-page'></a>
    <% } %>
    <% if(nextPage){ %>
      <a href='<%= nextPage %>' id='next-page'></a>
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
                <li><a href='#!/<%= App.getLocale() %>/companies/<%= company.get('id') %>'><%= company.get('name') %></a></li>
              <% }); %>
            </ul>
            <div class='clr'></div>
          </div>
        <% }); %>
      </div>
    <% }); %>
    <div class='clr'></div>
  </div>
  "
)