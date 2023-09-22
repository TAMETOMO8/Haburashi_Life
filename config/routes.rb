Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'static_pages#top'
  get '/after_login', to: 'static_pages#after_login'
  get 'user_sessions/login', to: 'users#login'
  get 'user_sessions/callback', to: 'users#callback'
  get 'logout', to: 'user_sessions#destroy'
  resources :toothbrushes, only: %i[new]
end
