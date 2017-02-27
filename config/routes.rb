Rails.application.routes.draw do
  devise_for :users
  root 'welcome#home'
  resources :posts
  resources :subscriptions, only: [:create, :destroy, :index]
  resources :users, only: [:index, :show]
  resources :notifications, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
