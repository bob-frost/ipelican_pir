window.JST['header'] = _.template(
  "<div>
    <div id='header-inner'>
      <div id='search-bar'>
        <div id='search-summary' class='nav-el' style='display:none'>
          <div class='title'><%= I18n.t('search.title') %></div>
          <%= I18n.t('search.results') %>: <span class='count'></span>
        </div>

        <div class='search-form nav-el' id='search-form-name' style='display:none'>
          <span class='label'><%= I18n.t('search.enter_label') %></span>
          &nbsp;
          <input type='text' name='name' class='search-field' placeholder='<%= I18n.t('search.by_name_placeholder') %>' />
          <button class='btn btn-large'><%= I18n.t('search.submit') %></button>
          <a href='#!/<%= App.getLocale() %>/companies' class='btn btn-large'><%= I18n.t('list') %></a>
        </div>
        <div class='search-form nav-el' id='search-form-activity_types' style='display:none'>
          <span class='label'><%= I18n.t('search.choose_label') %></span>
          &nbsp;
          <select name='activity_types' class='search-field' data-placeholder='<%= I18n.t('search.by_activity_type_placeholder') %>'>
            <option></option>
            <% _.each(App.activityTypes, function(opt){ %>
              <option value='<%= opt %>'><%= opt %></option>
            <% }) %>
          </select>
          <button class='btn btn-large'><%= I18n.t('search.submit') %></button>
        </div>
        <div class='search-form nav-el' id='search-form-brands' style='display:none'>
          <span class='label'><%= I18n.t('search.choose_label') %></span>
          &nbsp;
          <select name='brands' class='search-field' data-placeholder='<%= I18n.t('search.by_brand_placeholder') %>'>
            <option></option>
            <% _.each(App.brands, function(opt){ %>
              <option value='<%= opt %>'><%= opt %></option>
            <% }) %>
          </select>
          <button class='btn btn-large'><%= I18n.t('search.submit') %></button>
        </div>
        <div class='search-form nav-el' id='search-form-equipment_types' style='display:none'>
          <span class='label'><%= I18n.t('search.choose_label') %></span>
          &nbsp;
          <select name='equipment_types' class='search-field' data-placeholder='<%= I18n.t('search.by_equipment_type_placeholder') %>'>
            <option></option>
            <% _.each(App.equipmentTypes, function(opt){ %>
              <option value='<%= opt %>'><%= opt %></option>
            <% }) %>
          </select>
          <button class='btn btn-large'><%= I18n.t('search.submit') %></button>
        </div>
        <div id='search-buttons' class='nav-el'>
          <span class='label'><%= I18n.t('search.label') %></span>
          &nbsp;
          <button class='btn btn-large' data-type='name'><%= I18n.t('search.by_name') %></button>
          <button class='btn btn-large' data-type='activity_types'><%= I18n.t('search.by_activity_type') %></button>
          <button class='btn btn-large' data-type='brands'><%= I18n.t('search.by_brand') %></button>
          <button class='btn btn-large' data-type='equipment_types'><%= I18n.t('search.by_equipment_type') %></button>
        </div>
      </div>
      <button class='btn btn-large nav-el' id='clear-search' style='display:none'><%= I18n.t('search.clear') %></button>
      <div id='language-bar' class='nav-el' style='display:block'>
        <% if(App.getLocale() == 'ru'){ %>
          <span class='btn active' id='language-ru'>Рус</span><a href='#!/en' class='btn' id='language-en'>Eng</a>
        <% }else{ %>
          <a href='#!/ru' class='btn' id='language-ru'>Рус</a><span class='btn active' id='language-en'>Eng</span>
        <% } %>
      </div>
      <a href='#!/<%= App.getLocale() %>' class='btn btn-large nav-el' id='back-to-map' style='display:none'><%= I18n.t('back_to_map') %></a>
      <a href='#!/<%= App.getLocale() %>/companies' class='btn btn-large nav-el' id='back-to-companies' style='display:none'><%= I18n.t('back_to_companies') %></a>
      <div class='clr'></div>
    </div>
  </div>"
)