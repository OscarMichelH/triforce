Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new'
    end

    authenticated do
      root 'users#index', as: :authenticated_root
      resources :users, only: [:index, :new, :create, :edit, :show, :update, :destroy]
    end
  end
end
