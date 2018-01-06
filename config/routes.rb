Rails.application.routes.draw do
  root 'home#index'

  get 'login' => 'user_sessions#new'
  post 'login' => 'user_sessions#create'
  get 'logout' => 'user_sessions#destroy'
  get 'terms' => 'static_pages#terms'
  get 'privacy' => 'static_pages#privacy'
  post 'email_verify_token' => 'email_verify_token#create'

  resources :email_verify, only: [:show]

  resources :users, only: [:new, :create, :update, :show] do
    get 'complete', on: :collection
  end

  resources :reset_password, only: [:new, :create, :edit, :update] do
    get 'complete', on: :collection
  end

  get '/auth/:provider/callback' => 'sessions#create'


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  namespace :api, defaults: { format: :json } do
    resources :hoge, only: [:index]
  end

  resources :hoge, only: [:index]
  post 'hoge' => 'hoge#index'
  get 'hoge/:id' => 'hoge#index'
end
