window.JST['home'] = _.template(
  "
    <img src='images/map.png' usemap='#map' id='map' width='1246' height='519' />
    <map name='map'>
      <% _.each(STANDS, function(data, id){ %>
        <area
         href='#'
         shape='poly'
         alt='<%= id %>'
         title='<%= id %>'
         coords='<%= data.coords %>' />
      <% }) %>
    </map>
    <div id='business-zone-area'></div>
  "
)

window.JST['mapTooltip'] = _.template(
  "
    <div class='map-tooltip-wrapper hidden'>
      <div class='map-tooltip'>
        <img src='<%= company.image() %>' />
        <div class='details'>
          <div class='name'><%= company.get('name') %></div>
          <% if(company.acivityTypesText()){ %>
            <div class='description'><%= company.acivityTypesText() %></div>
          <% } %>
          <div class='clr'></div>
          <a href='#!/<%= App.getLocale() %>/companies/<%= company.get('id') %>' class='btn'><%= I18n.t('read_more') %></a>
        </div>
        <span class='btn close'>X</span>
        <div class='arr'></div>
      </div>
    </div>
  "
)