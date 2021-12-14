Rails.application.routes.draw do

  get 'relationships/following'
  get 'relationships/followed'
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users
  root to: 'homes#top'

  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'following' => 'relationships#following', as: 'following'
    get 'followed' => 'relationships#followed', as: 'followed'
  end
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'

  resources :maps, only: [:index]

  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy ] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get 'users/:id/favorites_index' => 'posts#favorites_index', as: 'favorites_index'
  get 'ranking_index' => 'posts#ranking_index', as: 'ranking_index'


  # get '/map_request', to: 'maps#map', as: 'map_request'

  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show]

end
