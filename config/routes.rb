Rails.application.routes.draw do

  get 'comments/create'
  get 'comments/destroy'
  devise_for :users
  root to: 'homes#top'

  resources :users, only: [:show, :edit, :update, :destroy]
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'

  resources :maps, only: [:index]
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy ] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  # get '/map_request', to: 'maps#map', as: 'map_request'



end
