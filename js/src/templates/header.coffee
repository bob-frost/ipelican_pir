window.JST['header'] = _.template(
  "<div>
    <div id='header-inner'>
      <div id='search-bar'>
        <span class='label'><%= I18n.t('search_by.label') %></span>
        &nbsp;
        <button class='btn'><%= I18n.t('search_by.name') %></button>
        <button class='btn'><%= I18n.t('search_by.activity_type') %></button>
        <button class='btn'><%= I18n.t('search_by.brand') %></button>
        <button class='btn'><%= I18n.t('search_by.equipment_type') %></button>
      </div>
      <div id='language-bar' style='display:<%= App.router.current == 'map' ? 'block' : 'none' %>'>
        <% if(App.getLocale() == 'ru'){ %>
          <span class='btn active' id='language-ru'>Рус</span><a href='#!/en' class='btn' id='language-en'>Eng</a>
        <% }else{ %>
          <a href='#!/ru' class='btn' id='language-ru'>Рус</a><span class='btn active' id='language-en'>Eng</span>
        <% } %>
      </div>
      <a href='#!/<%= App.getLocale() %>' class='btn' id='back-to-map' style='display:<%= App.router.current == 'map' ? 'none' : 'block' %>'>Вернуться к карте</a>
      <div class='clr'></div>
    </div>
  </div>"
)