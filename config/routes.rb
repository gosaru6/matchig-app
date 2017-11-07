Rails.application.routes.draw do

  root 'posts#top'

  resources :users
  get '/interpreter', to: 'users#interpreter'

  resources :posts
  resources :sessions, only: [:new, :create, :destroy]

  resources :conversations do
    resources :messages
  end
end
