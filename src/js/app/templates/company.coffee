window.JST['company'] = _.template(
  "
    <div class='image'>
      <img src='<%= company.image() %>' />
    </div>
    <h1><%= company.get('name') %></h1>
    <ul class='details'>
      <% if(company.get('location')){ %>
        <li>
          <span><%= I18n.t('location') %>:</span>
          <%= company.get('location') %>
        </li>
      <% } %>
      <% if(company.get('phone')){ %>
        <li>
          <span><%= I18n.t('phone') %>:</span>
          <%= company.get('phone') %>
        </li>
      <% } %>
      <% if(company.get('email')){ %>
        <li>
          <span><%= I18n.t('email') %>:</span>
          <a href='mailto:<%= company.get('email') %>'>
          <%= company.get('email') %></a>
        </li>
      <% } %>
      <% if(company.get('site')){ %>
        <li>
          <span><%= I18n.t('site') %>:</span>
          <a href='<%= company.siteUrl() %>' target='_blank'><%= company.siteName() %></a>
        </li>
      <% } %>
      <li>
        <span><%= I18n.t(stands.length > 1 ? 'stands' : 'stand') %>:</span>
        <% _.each(stands, function(stand, i){ %>
          <a href='#!/<%= App.getLocale() %>/select/<%= stand %>'><%= stand %></a><% if(i + 1 < stands.length ){ %>,<% } %>
        <% }); %>
      </li>
    </ul>
    <div class='clr'></div>
    <% if(company.get('description')){ %>
      <div class='description'>
        <%= company.get('description') %>
      </div>
    <% } %>
    
  "
)