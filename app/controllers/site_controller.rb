class SiteController < ApplicationController
  
  I18n.load_path = ['lib/translations.rb']
  I18n.default_locale = 'it-IT'
  
  before_filter do |controller|
    I18n.locale = controller.language
  end
  
  def language; {'it' => 'it-IT', 'en' => 'en-US'}[ params[:language] || 'it' ] end
  hide_action :language
  
end
