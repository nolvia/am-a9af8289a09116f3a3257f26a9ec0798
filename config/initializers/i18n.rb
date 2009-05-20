# I18n.load_path << 'lib/translations.rb'
# I18n.load_path << 'lib/translations.yml'
# I18n.load_path << 'lib/translations/services.yml'
# I18n.load_path << 'lib/translations/portfolio.rb'


# Dir['lib/locales/**/*'].each do |translation|
#   I18n.load_path << translation if File.file? translation
# end


I18n.load_path = Dir['config/locales/*.yml']
