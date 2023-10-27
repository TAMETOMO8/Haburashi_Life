Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'static_pages#top'
  get 'toothbrush/search', to: 'toothbrushes#search'
  get 'user_sessions/login', to: 'user_sessions#login'
  get 'user_sessions/callback', to: 'user_sessions#callback'
  delete 'logout', to: 'users#destroy'
  resources :toothbrushes, only: %i[new create index edit update destroy]
  resources :users, only: %i[edit update]
end
