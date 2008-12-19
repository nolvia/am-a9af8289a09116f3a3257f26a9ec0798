ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'site', :language => 'it'
  
  map.reset 'reset', :controller => 'site', :action => 'expire_all'
  
  def site_path map, action_name
    map.with_options  :controller => 'site', :action => action_name do |site|
      site.with_options :requirements => {:language => /it|en/} do |site_with_language|
        site_with_language.connect           ":language" if action_name.to_s == 'index'
        site_with_language.connect           ":language/#{action_name}"
        site_with_language.connect           ":language/#{action_name}.htm"
        site_with_language.send action_name, ":language/#{action_name}.html"
      end
      # site.with_options :language => 'it' do |site|
      site.connect                        "#{action_name}"
      site.connect                        "#{action_name}.htm"
      site.send "#{action_name}_default", "#{action_name}.html"
      # end
    end
  end
  
  %w[index home about services portfolio contacts].each do |action_name|
    site_path map, action_name
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
