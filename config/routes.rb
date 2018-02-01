Rails.application.routes.draw do
  root to: "home#index"

  resources :articles, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :tags, only: [:index, :show]
end
