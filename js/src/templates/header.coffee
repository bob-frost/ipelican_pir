window.JST['header'] = _.template(
  "<div>
    <div id='header-inner'>
      <div id='search-bar'>
        <div class='search-form' id='search-form-name' style='display:none'>
          <span class='label'><%= I18n.t('search.enter_label') %></span>
          &nbsp;
          <input type='text' placeholder='<%= I18n.t('search.by_name_placeholder') %>' />
          <button class='btn'><%= I18n.t('search.submit') %></button>
        </div>
        <div class='search-form' id='search-form-activity-type' style='display:none'>
          <span class='label'><%= I18n.t('search.choose_label') %></span>
          &nbsp;
          <select>
            <option value=''><%= I18n.t('search.by_activity_type_placeholder') %></option>
            <option value='activity 1'>activity 1</option>
            <option value='activity 2'>activity 2</option>
            <option value='activity 2'>activity 2</option>
          </select>
          <button class='btn'><%= I18n.t('search.submit') %></button>
        </div>
        <div class='search-form' id='search-form-brand' style='display:none'>
          <span class='label'><%= I18n.t('search.choose_label') %></span>
          &nbsp;
          <select>
            <option value=''><%= I18n.t('search.by_brand_placeholder') %></option>
            <option value='brand 1'>brand 1</option>
            <option value='brand 2'>brand 2</option>
            <option value='brand 2'>brand 2</option>
          </select>
          <button class='btn'><%= I18n.t('search.submit') %></button>
        </div>
        <div class='search-form' id='search-form-equipment-type' style='display:none'>
          <span class='label'><%= I18n.t('search.choose_label') %></span>
          &nbsp;
          <select>
            <option value=''><%= I18n.t('search.by_equipment_type_placeholder') %></option>
            <option value='equipment 1'>equipment 1</option>
            <option value='equipment 2'>equipment 2</option>
            <option value='equipment 2'>equipment 2</option>
          </select>
          <button class='btn'><%= I18n.t('search.submit') %></button>
        </div>
        <div id='search-buttons'>
          <span class='label'><%= I18n.t('search.label') %></span>
          &nbsp;
          <button class='btn' data-type='name'><%= I18n.t('search.by_name') %></button>
          <button class='btn' data-type='activity-type'><%= I18n.t('search.by_activity_type') %></button>
          <button class='btn' data-type='brand'><%= I18n.t('search.by_brand') %></button>
          <button class='btn' data-type='equipment-type'><%= I18n.t('search.by_equipment_type') %></button>
        </div>
      </div>
      <button class='btn' id='clear-search' style='display:none'><%= I18n.t('search.clear') %></button>
      <div id='language-bar' style='display:block'>
        <% if(App.getLocale() == 'ru'){ %>
          <span class='btn active' id='language-ru'>Рус</span><a href='#!/en' class='btn' id='language-en'>Eng</a>
        <% }else{ %>
          <a href='#!/ru' class='btn' id='language-ru'>Рус</a><span class='btn active' id='language-en'>Eng</span>
        <% } %>
      </div>
      <a href='#!/<%= App.getLocale() %>' class='btn' id='back-to-map' style='display:none'><%= I18n.t('back_to_map') %></a>
      <div class='clr'></div>
    </div>
  </div>"
)