Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'static_pages#top'
  get 'user_show_from_richmenu', to: 'static_pages#user_show_from_richmenu'
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'tutorial', to: 'static_pages#tutorial'
  get 'toothbrush/:toothbrush_id/dental_item/search', to: 'dental_items#search', as: 'dental_items_search'
  get 'toothbrush/search', to: 'toothbrushes#search'
  get 'user_sessions/login', to: 'user_sessions#login'
  get 'user_sessions/callback', to: 'user_sessions#callback'
  delete 'logout', to: 'user_sessions#destroy'
  resources :toothbrushes do
    member do
      get 'update_state'
    end
    resources :dental_items, only: %i[new create update edit]
    get :index_search, on: :collection
  end
  resources :users, only: %i[edit update show]
end
