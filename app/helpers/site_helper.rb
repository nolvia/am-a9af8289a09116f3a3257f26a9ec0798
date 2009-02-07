module SiteHelper
  def language
    params[:language] || 'it'
  end
  
  def localized_root
    language == 'it' ? root_path : local_root_path(language)
  end
  
  def macok_address_map_url
    'http://maps.google.com/maps?f=q&amp;hl=it&amp;q=MACOK+loc%3A+Via+Toscana,+10a+carugate+MI+italy&amp;ie=UTF8&amp;ll=45.550602,9.334388&amp;spn=0.003817,0.010042&amp;z=17&amp;iwloc=A&amp;om=1'
  end
  
  def section_links *action_names
    action_names.map do |action_name|
      url = send "#{action_name}_path", language
      name = t(action_name, :scope => :sections) + #'<br />' +
             image_tag("sections/#{action_name.to_s}.png")
      options = {:id => action_name}
      options[:class] = :active if current_page?(url)
      
      link_to name, url, options
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
      link_to image_tag("flags/#{t 'language.short'}.gif")+" #{t 'language.name'}", 
      send( controller.action_name+'_path', t('language.short') )
    end
  end
end
