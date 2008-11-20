module SiteHelper
  def language
    params[:language] || 'it'
  end
  
  def macok_gmaps_url
    'http://maps.google.com/maps?f=q&amp;hl=it&amp;q=MACOK+loc%3A+Via+Toscana,+10a+carugate+MI+italy&amp;ie=UTF8&amp;ll=45.550602,9.334388&amp;spn=0.003817,0.010042&amp;z=17&amp;iwloc=A&amp;om=1'
  end
  
  def section_links *action_names
    action_names.map do |action_name|
      url = send "#{action_name}_path", language
      style = ' style="display:block;"' if action_name == action_names.first or
                                          action_name == action_names.last
      link_content = "<span#{style}>" + 
                       t(action_name, :scope => :sections) + '<br />' +
                    	 image_tag("sections/#{action_name.to_s}.png") + 
                  	 '</span><br />'
      link_to link_content, url, :style => 'text-decoration:none;', :id => action_name
    end.join "\n"
  end
  
  def with_locale locale
    locale_backup = I18n.locale
    I18n.locale = locale
    result = yield locale
    I18n.locale = locale_backup
    return result
  end
  
  # def with_translation_scope scope = nil, &block
  #   locale_backup = I18n.locale
  #   I18n.locale = locale
  #   result = yield locale
  #   I18n.locale = locale_backup
  #   return result
  # end
  
  def link_to_language locale
    with_locale locale do 
      link_to image_tag("flags/#{t 'language.short'}.gif")+" #{t 'language.name'}", :action => controller.action_name, :language => t('language.short')
    end
  end
end
