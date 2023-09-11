Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'static_pages#top'
  get '/after_login', to: 'static_pages#after_login'
  get 'user_sessions/login', to: 'user_sessions#login'
  get 'user_sessions/callback', to: 'user_sessions#callback'
  get 'logout', to: 'user_sessions#destroy'
  get 'toothbrushes/search'
end
