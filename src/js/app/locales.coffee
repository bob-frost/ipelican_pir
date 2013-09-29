window.I18n ||= {}

I18n.pluralizationRules.ru = (n) ->
  (if n % 10 is 1 and n % 100 isnt 11 then "one" else (if [2, 3, 4].indexOf(n % 10) >= 0 and [12, 13, 14].indexOf(n % 100) < 0 then "few" else (if n % 10 is 0 or [5, 6, 7, 8, 9].indexOf(n % 10) >= 0 or [11, 12, 13, 14].indexOf(n % 100) >= 0 then "many" else "other")))

window.I18n.translations =
  ru:
    search:
      title: 'Поиск'
      label: 'Искать по:'
      enter_label: 'Введите'
      choose_label: 'Выберите'
      by_name: 'Названию компании'
      by_name_placeholder: 'название компании'
      by_activity_type: 'Виду деятельности'
      by_activity_type_placeholder: 'вид деятельности'
      by_brand: 'Бренду'
      by_brand_placeholder: 'бренд'
      by_equipment_type: 'Типу оборудования'
      by_equipment_type_placeholder: 'тип оборудования'
      submit: 'Найти'
      clear: 'Очистить'
      results: 'Результаты поиска'
      result_stands:
        one: '1 стенд'
        few: '{{count}} стенда'
        many: '{{count}} стендов'
        other: '{{count}} стенда'
      result_titles:
        name: 'Название компании'
        activity_types: 'Вид деятельности'
        brands: 'Бренд'
        equipment_types: 'Тип оборудования'
    back_to_map: 'Вернуться к карте'
    back_to_companies: 'Вернуться к списку'
    name: ''
    activity_types: ''
    brands: ''
    equipment_types: ''
    location: 'Адрес' 
    phone: 'Телефон'
    email: 'Email'
    site: 'Веб-сайт'
    read_more: 'Читать подробнее'
    go_to_companies: 'Перейти к списку компаний'
    page_not_found: 'Страница не найдена'
    no_matches: 'Совпадений не найдено'
    stand: 'Стенд'
    stands: 'Стенды'
    business_area: 'Бизнес зона'
    list: 'Список'

  en:
    search:
      title: 'Search'
      label: 'Search by:'
      enter_label: 'Enter'
      choose_label: 'Choose'
      by_name: 'Company name'
      by_name_placeholder: 'company name'
      by_activity_type: 'Activity type'
      by_activity_type_placeholder: 'activity type'
      by_brand: 'Brand'
      by_brand_placeholder: 'brand'
      by_equipment_type: 'Equipment type'
      by_equipment_type_placeholder: 'equipment type'
      submit: 'Search'
      clear: 'Clear'
      results: 'Search results'
      result_stands:
        zero: '0 stands'
        one: '1 stand'
        other: '{{count}} stands'
      result_titles:
        name: 'Company name'
        activity_types: 'Activity type'
        brands: 'Brand'
        equipment_types: 'Equipment type'
    back_to_map: 'Back to map'
    back_to_companies: 'Back to list'
    equipment_types: ''
    location: 'Location' 
    phone: 'Phone'
    email: 'Email'
    site: 'Website'
    read_more: 'Read more'
    go_to_companies: 'Show all companies'
    page_not_found: 'Page not found'
    no_matches: 'No matches found'
    stand: 'Stand'
    stands: 'Stands'
    business_area: 'Business area'
    list: 'List'

(($) ->
  "use strict"
  $.extend $.fn.select2.defaults,
    formatNoMatches: ->
      I18n.translations[App.getLocale()]['no_matches']

) jQuery