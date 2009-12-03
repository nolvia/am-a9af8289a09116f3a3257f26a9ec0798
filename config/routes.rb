ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'site', :action => :index
  
  Localizer.localize! :index, :downloads, :pictures, :life, :contacts, 
                      :to => [:en], :from => :site
  map.include_localized_routes!
  
  
  map.connect ':action/:id',          :controller => 'site'
  map.connect ':action/:id.:format',  :controller => 'site'
end
