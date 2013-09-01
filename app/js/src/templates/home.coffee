window.JST['home'] = _.template(
  "
    <img src='images/map.png' usemap='#map' id='map' width='1246' height='519' />
    <map name='map'>
      <% _.each(STANDS, function(stand){ %>
        <area
         href='#'
         shape='poly'
         alt='<%= stand.id %>'
         title='<%= stand.id %>'
         coords='<%= stand.coords %>' />
      <% }) %>
    </map>
  "
)