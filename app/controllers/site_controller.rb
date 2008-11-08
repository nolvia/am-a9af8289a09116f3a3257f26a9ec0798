class SiteController < ApplicationController
  before_filter do |controller|
    I18n.default_locale = controller.language
  end
  
  def language; {'it' => 'it-IT', 'en' => 'en-US'}[ params[:language] || 'it' ] end
  hide_action :language
  
end
