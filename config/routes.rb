Rails.application.routes.draw do

  get 'relationships/create'

  get 'relationships/destroy'

  root 'posts#top'

  resources :users
  get '/interpreter', to: 'users#interpreter'

  resources :posts
  resources :sessions, only: [:new, :create, :destroy]

  resources :conversations do
    resources :messages
  end

  resources :relationships, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
