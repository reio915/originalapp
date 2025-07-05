Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations',sessions: 'users/sessions' }
  resources :users, only: [:show] # ユーザーマイページへのルーティング
get 'hello/index' => 'hello#index'
get 'hello/link' => 'hello#link'
get 'tweets/search' => 'tweets#search'
get 'tweets/:tweet_id/likes' => 'likes#create'
get 'tweets/:tweet_id/likes/:id' => 'likes#destroy'
resources :tweets do
resources :likes, only: [:create, :destroy]
resources :comments, only: [:create]
end
resources :users do
 collection do
 get :search # ユーザー検索用
end
member do 
get :following, :followers 
end 
end
resources :relationships, only: [:create, :destroy]
root 'hello#index'
end