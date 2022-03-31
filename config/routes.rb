Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    unauthenticated do
      root 'books#index'
    end

    authenticated do
      root 'books#index', as: :authenticated_root
      resources :users, only: [:index, :new, :create, :edit, :show, :update, :destroy]
      resources :books
      get '/add_book/:book_id', to: 'carts#add_book', as: 'add_book'
      delete '/delete_book/:book_id', to: 'carts#delete_book', as: 'delete_book'
      get '/pay_cart', to: 'carts#pay_cart', as: 'pay_cart'
      resources :sales
      resources :carts
    end
  end
end
