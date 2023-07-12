Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'

  resources :categories, only: [:index, :new, :show, :create] do
    resources :entities, only: [:index, :new, :create]
  end
end
