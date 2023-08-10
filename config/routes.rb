Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  unauthenticated do
    root to: 'home#index', as: 'home_root'
  end

  root 'categories#index'

  resources :categories, only: %i[index new create] do
    resources :entities, only: %i[index show new create]
  end
end
