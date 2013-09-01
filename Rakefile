gem 'json'
gem 'rubyzip', '~> 0.9.0'
gem 'roo', '~> 1.11.0'
gem 'coffee-script'
gem 'uglifier'

require 'rubygems'
require 'uri'
require 'open-uri'
require 'json'
require 'roo'
require 'coffee-script'
require 'uglifier'

task :parse do
  START_ROW                  = 2
  ID_COLUMN                  = 1
  NAME_COLUMN                = 0
  DESCRIPTION_COLUMN         = 4
  LOCATION_COLUMN            = 5
  PHONE_COLUMN               = 6
  SITE_COLUMN                = 7
  BRANDS_COLUMN              = 8
  EQUIPMENT_TYPES_COLUMN     = 9
  IMAGE_COLUMN               = 11
  ACTIVITY_TYPES_COLUMN      = 12
  BRANDS_COLUMN_SEP          = ','
  EQUIPMENT_TYPES_COLUMN_SEP = ','
  ACTIVITY_TYPES_COLUMN_SEP  = ';'

  res = 'window.DATA = {};'

  Dir.glob(File.expand_path("../import/*.xlsx", __FILE__)).each do |path|
    puts "Importing #{path}"
    data = []
    file = Roo::Spreadsheet.open(path)

    for i in START_ROW..file.last_row do
      attributes, errors = {}, []
      begin
        row = file.row i

        id = row[ID_COLUMN].to_s.strip
        if id.empty?
          errors << "Stand number can't be blank"
        elsif data.detect{ |i| i[:id] == id }
          errors << "Stand number '#{id}' already exists"
        else
          attributes[:id] = id
        end

        name = row[NAME_COLUMN].to_s.strip
        if name.empty?
          errors << "Name can't be blank"
        else
          attributes[:name] = name
        end

        %w(DESCRIPTION_COLUMN LOCATION_COLUMN PHONE_COLUMN SITE_COLUMN).each do |column|
          attribute = row[eval(column)].to_s.strip
          attributes[column.gsub('_COLUMN', '').downcase.to_sym] = attribute unless attribute.empty?
        end

        image_url = row[IMAGE_COLUMN].to_s.strip
        unless image_url.empty?
          filename = File.basename(URI.parse(image_url).path)
          File.write(File.expand_path("../app/data/images/#{filename}", __FILE__), open(image_url).read, {:mode => 'wb'})
          attributes[:image] = filename
        end

        %w(BRANDS_COLUMN EQUIPMENT_TYPES_COLUMN ACTIVITY_TYPES_COLUMN).each do |column|
          sep = eval("#{column}_SEP")
          attribute = row[eval(column)].to_s.squeeze(sep).split(sep).map{ |a| a.strip }.sort
          attributes[column.gsub('_COLUMN', '').downcase.to_sym] = attribute
        end

        unless errors.any?
          data << attributes
        else
          msg = "Couldn't import row #{i}\n"
          msg << errors.join("\n")
          msg << "\n\n"
          puts msg
        end
      rescue Exception => e
        msg = "Couldn't import row #{i}\n#{e.message}\n"
        msg << e.backtrace[0..3].join("\n")
        msg << "\n\n"
        puts msg
      end    
    end

    json = JSON.generate(data)
    locale = File.basename(path, '.xlsx')
    res << "\nwindow.DATA.#{locale} = #{json};"
  end

  filename = File.expand_path('../app/data/companies.js', __FILE__)
  File.open(filename, 'w') { |file| file.write(res) }
end

task :compile do
  # To preserve order
  vendors = ['jquery', 'underscore', 'backbone', 'i18n']
  src_dirs = ['', 'ext', 'templates', 'models', 'collections', 'views', 'routers']
  js = []

  vendors.each do |vendor|
    js << File.read(File.expand_path("../app/js/vendor/#{vendor}.js", __FILE__))
  end

  coffee = []
  src_dirs.each do |dir|
    Dir.glob(File.expand_path("../app/js/src/#{dir}/*.coffee", __FILE__)) do |file|
      coffee << File.read(file)
    end
  end
  js << CoffeeScript.compile(coffee.join("\n"))
  js = js.join("\n")
  # js = Uglifier.compile js.join("\n")

  filename = File.expand_path('../app/js/app.js', __FILE__)
  File.open(filename, 'w') { |file| file.write(js) }
end