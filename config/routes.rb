Rails.application.routes.draw do
  get 'account/reset_password/new'
  get 'account/change_password/new'

  root 'home#index'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  get 'logout' => 'user_sessions#destroy'
  resources :users, only: [:new, :create, :edit, :update, :show]
end
