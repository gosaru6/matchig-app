Rails.application.routes.draw do

  root 'posts#top'

  resources :users do
    member do
      get 'follow'
      get 'follower'
    end

    collection do
      get 'interpreter'
    end
  end

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
