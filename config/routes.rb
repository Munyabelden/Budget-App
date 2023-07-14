Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: "home#index", as: "home_root"
  end

  root "categories#index"

  resources :categories, only: [:index, :new, :create] do
    resources :entities, only: [:index, :show, :new, :create]
  end
end
