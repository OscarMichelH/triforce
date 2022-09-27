Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    unauthenticated do
      root 'items#index'
    end

    authenticated do
      root 'items#index', as: :authenticated_root
      resources :users, only: [:index, :new, :create, :edit, :show, :update, :destroy]
      resources :items
      get '/add_item/:item_id', to: 'carts#add_item', as: 'add_item'
      delete '/delete_item/:item_id', to: 'carts#delete_item', as: 'delete_item'
      get '/pay_cart', to: 'carts#pay_cart', as: 'pay_cart'
      resources :sales, only: [:index, :create, :update, :destroy]
      resources :carts
    end
  end
end
