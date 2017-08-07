Rails.application.routes.draw do
  root 'home#index'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  get 'logout' => 'user_sessions#destroy'
  resources :users, only: [:new, :create, :edit, :update, :show]
end
