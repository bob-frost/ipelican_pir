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
    <div id='business-area'></div>
  "
)
