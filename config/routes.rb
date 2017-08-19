Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'

  namespace :account do
    resources :reset_password, only: [:new, :create, :edit, :update]
    resources :change_password, only: [:new, :create]
  end

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  get 'logout' => 'user_sessions#destroy'
  resources :users, only: [:new, :create, :edit, :update, :show]


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
