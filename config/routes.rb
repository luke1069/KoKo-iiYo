Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :users, only: [:show, :edit, :update, :destroy]
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'

  resources :maps, only: [:index]
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy ]
  # get '/map_request', to: 'maps#map', as: 'map_request'



end
