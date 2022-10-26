Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
    root to: "home#index"

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
