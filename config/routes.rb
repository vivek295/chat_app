Rails.application.routes.draw do
  devise_for :users
  root 'welcome#home'
  resources :posts do
  	collection do
  		get 'feed',to: 'posts/feed'
      get 'recent_posts', to: 'posts/recent_posts'
  	end
  end
  resources :users, only: [:profile] do 
    member do
      get 'profile',to: 'users#profile'
    end
  end
  resources :subscriptions, only: [:create, :destroy, :index]
  resources :users, only: [:index, :show]
  resources :notifications, only: [:index]
  resources :message_notifications, only: [:index]
  resources :conversations, only: [:index, :create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
