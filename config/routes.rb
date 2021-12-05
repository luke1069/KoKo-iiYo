Rails.application.routes.draw do

  # googlemap_api関連
  resources :maps, only: [:index]
  get '/map_request', to: 'maps#map', as: 'map_request'

  devise_for :users
  root to: 'homes#top'
end
