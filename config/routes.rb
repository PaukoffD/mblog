Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  
  
 
 
  root 'posts#index'
  
  get '/:year(/:month)(/:day)' => 'posts#archive', :as => :archive, 
   :constraints => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/}
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
     resources :posts do
	   resources :comments
    end
  
end
