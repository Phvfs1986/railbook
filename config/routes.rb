# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'users/create_request/:id', to: 'users#create_request', as: 'user_create_request'
  get 'users/friend_list/:id', to: 'users#friend_list', as: 'user_friend_list'
  resources :profiles, only: %i[show edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
end
