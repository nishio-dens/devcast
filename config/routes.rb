Rails.application.routes.draw do
  root to: "home#index"

  resources :articles, only: [:index, :show]
  resources :categories, only: [:show]
  resources :tags, only: [:show]

  get 'feed', to: "feeds#index", as: "feed"
end
