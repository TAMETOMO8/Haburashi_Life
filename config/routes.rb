Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'static_pages#top'
  get 'toothbrush/search', to: 'toothbrushes#search'
  get 'user_sessions/login', to: 'user_sessions#login'
  get 'user_sessions/callback', to: 'user_sessions#callback'
  delete 'logout', to: 'user_sessions#destroy'
  resources :toothbrushes do
    member do
      get 'update_state'
    end
  end
  resources :users, only: %i[edit update]
end
