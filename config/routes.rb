SWorD::Application.routes.draw do
#root per homepage
 root :to => 'pages#home'

 #named routs for static page and signIn signUp
  match '/about', to: 'pages#about'
  match '/contact', to: 'pages#contact'
  match '/faq', to: 'pages#faq'
  match '/sign_in', to: 'sessions#new'
  match '/sign_up', to: 'users#new'

 # signout should be performed by using the HTTP DELETE request
  match '/sign_out',  to: 'sessions#destroy', via: :delete

  # default routes for the Users controller
  resources :users   do
    member do
      get :following, :followers, :messages,:locals, :events, :my_events, :my_locals # ex.: get /users/1/followers
    end
    collection do
      get :search
    end
  end

  #default routes for the Locals controller
  resource :locals do
    member do
      get :followers
    end
  end

 resource :eventss do
   member do
     get :partecipanti
   end
 end

  #default routes for the Session controller
  resources :sessions,  only: [:new, :create, :destroy]

  # default routes for the Posts controller
  resources :posts, only: [:create, :destroy]

  # default routes for the Photos controller
  resources :photos, only: [:destroy]

  # default routes for Users_follow_locals cotroller
  resource :users_follow_locals, only: [:create, :destroy]

  # default routes for the Relatioship controller
  resources :relationship, only: [:create, :destroy]

 # default routes for Partecipa_evento controller
  resource :partecipa_events, only: [:create, :destroy]

   # default routes for the Messages controller
  # (only create and destroy - other operations will be done via the Users controller)
  resources :messages, only: [:new, :create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/home.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
