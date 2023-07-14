# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: 'home#index', as: 'home_root'
  end

  root 'categories#index'

  resources :categories, only: %i[index new create] do
    resources :entities, only: %i[index show new create]
  end
end
