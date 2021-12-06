Rails.application.routes.draw do

  # googlemap_api関連
  resources :maps, only: [:index]
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy ]
  # get '/map_request', to: 'maps#map', as: 'map_request'

  devise_for :users
  root to: 'homes#top'
end
