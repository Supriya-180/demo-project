Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
    root to: "home#index"



namespace :api, constraints: { format: :json } do
  namespace :v1, constraints: { format: :json } do
    devise_for :users, controllers: {
      sessions: 'api/v1/users/sessions',
      registrations: 'api/v1/users/registrations'
    },path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    }
    resources :users
  end
end

    namespace :api, constraints: { format: :json }  do
      namespace :v1, constraints: { format: :json }  do 
        resources :home do 
          get "/add_to_cart", to: "home#add_to_cart"  #post
          post "/like", to: "home#like"
        end
      end
    end

    namespace :api do
      namespace :v1 do 
        resources :products do 
          resources :comments
          collection do 
            get :options_for_variant
          end
        end
      end
    end
    
    get '/member-data', to: 'members#show'

    resources :home do 
      get "/add_to_cart", to: "home#add_to_cart"  #post
      post "/like", to: "home#like"
    end

    resources :carts do 
      post "/update_cart", to: "carts#update_cart"
      delete "/destroy_cart_item", to: "carts#destroy_cart_item", on: :member
    end

    post 'admin/products/change_variant_attribute' 

    resources :products do 
      resources :comments
      collection do 
        get :options_for_variant
      end
      post "/like", to: "products#like"
    end

    resources :variants

    resources :orders do 
      post "/place_order", to: "orders#place_order", on: :collection
      get "/show_order_item", to: "orders#show_order_item", on: :member
      get "/pay", to: "orders#pay", on: :member
      post "/payments", to: "orders#payments", on: :collection
      patch "/cancel_order", to: "orders#cancel_order", on: :member
      
    end

    resources :addresses

    resources :wishlists

end
