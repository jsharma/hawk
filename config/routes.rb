Hawk::Engine.routes.draw do
  resources :hawkers do
	get :delete_xpath, :on => :member
	post :create_update_xpath, :on => :member
  end
  # match "hawkers/:id/save_xpath", :to => "hawkers#save_xpath"
end
