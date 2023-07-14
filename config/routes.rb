# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'users/create_request/:id', to: 'users#create_request', as: 'user_create_request'
  get 'users/friend_list/:id', to: 'users#friend_list', as: 'user_friend_list'

  get 'likes/add_like/:id', to: 'likes#add_like', as: 'add_like'
  get 'likes/remove_like/:id', to: 'likes#remove_like', as: 'remove_like'

  resources :posts, except: [:show]
  resources :comments, only: %i[new create destroy]
  resources :users

  root 'users#index'
end
