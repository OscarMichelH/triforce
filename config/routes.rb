Rails.application.routes.draw do
  resources :carts
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new'
    end

    authenticated do
      root 'books#index', as: :authenticated_root
      resources :users, only: [:index, :new, :create, :edit, :show, :update, :destroy]
      resources :books
      get '/add_book/:book_id', to: 'carts#add_book', as: 'add_book'
    end
  end
end
