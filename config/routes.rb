Rails.application.routes.draw do
  get 'user/:id', to:'user#show', as: 'users'
  patch 'user', to:'user#update'
  get 'users/edit', to:'user#edit'
  get 'mypage', to: 'user#mypage'
  get 'follow/:id', to: 'user#followees', as: 'followees'
  get 'follower/:id', to: 'user#followers', as: 'followers'

  get 'post/:id/likes', to: 'posts#likes', as: :likes
  
  resources :user do
    post :follow, on: :member
  end

  devise_for :users
  resources :places
  root 'posts#index'
  resources :posts do
    resources :comments, :only => [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
