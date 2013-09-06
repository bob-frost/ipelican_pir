window.JST['mapTooltip'] = _.template(
  "
    <div class='map-tooltip-wrapper hidden'>
      <div class='map-tooltip'>
        <%= content %>
        <span class='btn close'>X</span>
        <div class='arr'></div>
      </div>
    </div>
  "
)
window.JST['mapCompanyTooltip'] = _.template(
  "
    <img src='<%= company.image() %>' />
    <div class='details'>
      <div class='name'><%= company.get('name') %></div>
      <% if(company.acivityTypesText()){ %>
        <div class='description'><%= company.acivityTypesText() %></div>
      <% } %>
      <div class='clr'></div>
      <a href='#!/<%= App.getLocale() %>/companies/<%= company.get('id') %>' class='btn'><%= I18n.t('read_more') %></a>
    </div>
  "
)
window.JST['mapBusinessAreaTooltip'] = _.template(
  "
    <img src='images/business-area-logo.png' />
    <div class='details'>
      <div class='name'><%= I18n.t('business_area') %></div>
      <div class='description'></div>
      <div class='clr'></div>
      <a href='http://ipelican.com' target='_blank' class='btn'><%= I18n.t('read_more') %></a>
    </div>
  "
)