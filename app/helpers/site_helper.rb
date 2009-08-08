module SiteHelper
  def locale
    params[:locale] || 'it'
  end
  
  def localized_root
    locale == 'it' ? root_path : local_root_path(locale)
  end
  
  def macok_address_map_url
    "http://maps.google.com/maps?f=q&amp;hl=#{locale || it}&amp;q=MACOK+loc%3A+Via+Toscana,+10a+carugate+MI+italy&amp;ie=UTF8&amp;ll=45.550602,9.334388&amp;spn=0.003817,0.010042&amp;z=17&amp;iwloc=A&amp;om=1"
  end
  
  def section_links *action_names
    action_names.map { |action_name| section_link action_name }.join "\n"
  end
  
  def section_link action_name
    url = send "#{action_name}_path", locale
    options = {:id => action_name}
    options[:class] = :active if current_page?(url)
    name = t(action_name, :scope => :sections, :default => action_name.to_s.humanize)
    
    link_to name, url, options
  end
  
  def with_locale locale
    locale_backup = I18n.locale
    I18n.locale = locale
    result = yield locale
    I18n.locale = locale_backup
    return result
  end
  
  def link_to_locale locale, name
    active = (I18n.locale.to_s == locale.to_s)
    link_to image_tag("flags/#{locale}_medium.png", :title => name), 
            send( controller.action_name+'_path', locale ), :class => (active ? 'active' : '')
  end
  
  def youtube_video(code, locale)
    %Q{<object width="425" height="344"><param name="movie" value="http://www.youtube.com/v/#{code}&hl=#{locale}&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/#{code}&hl=#{locale}&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>}
  end
  
  def youtube_link(code)
    "http://www.youtube.com/watch?v=#{code}"
  end
end
