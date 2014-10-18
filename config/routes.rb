Amazon::Application.routes.draw do
  get "omniauth_callbacks/facebook"
  devise_for :customers, :controllers => { :omniauth_callbacks => "customers/omniauth_callbacks" }  
  resources :customers, :only => [:index, :destroy] do
    collection do
      patch 'update_password', to: 'registrations#update_password'
      patch 'update_email', to: 'registrations#update_email'
      patch 'destroy_account', to: 'registrations#destroy_account'
      post 'create_billing_address', to: 'registrations#create_billing_address'
      post 'create_shipping_address', to: 'registrations#create_shipping_address'
      get 'edit_account', to: 'registrations#edit'
    end
  end
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root "books#index"
  resources :categories
  resources :books do
    resources :ratings, only: [:create, :new]
  end
  resources :orders do
    get 'confirm'
    delete 'empty_cart'
    get 'new_delivery'
    patch 'create_delivery'
    get 'edit_delivery'
    patch 'update_delivery'
    get 'complete'
    resources :order_items
  end
  resources :addresses do
    get 'new_shipping', on: :collection
    post 'create_shipping', on: :collection
    get 'edit_shipping'
    patch 'update_shipping'
    put 'update_shipping'
  end
  resources :credit_cards
  get 'shopping_cart', to: 'orders#shopping_cart'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
