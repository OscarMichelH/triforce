Rails.application.routes.draw do
  resources :discounts
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    unauthenticated do
      root 'items#index'
    end

    authenticated do
      root 'items#index', as: :authenticated_root
      get '/add_credits', to: 'users#show_add_credits', as: 'show_add_credits'
      post '/add_credits', to: 'users#add_credits', as: 'add_credits'
      resources :users do
        get 'reload_balance', to: 'users#reload_balance', as: 'reload_balance'
      end
      resources :items do
        member do
          delete :delete_image_attachment
        end
      end
      get '/add_item/:item_id', to: 'carts#add_item', as: 'add_item'
      delete '/delete_item/:item_id', to: 'carts#delete_item', as: 'delete_item'
      get '/pay_cart', to: 'carts#pay_cart', as: 'pay_cart'
      resources :sales, only: [:index, :create, :update, :destroy]
      resources :carts
        end
  end
end
