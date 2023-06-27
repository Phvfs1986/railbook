# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :profiles, only: %i[show edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
end
