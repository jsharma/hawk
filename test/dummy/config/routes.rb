Rails.application.routes.draw do
  mount Hawk::Engine => "/hawk"
  root :to => "hawkers#index"
end
