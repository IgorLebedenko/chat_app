Rails.application.routes.draw do
  resources :users do
    member do
      get :messages
    end
  end
  resources :messages, only: [:create, :update, :destroy]
  resources :chats do
    member do
      get :members
    end
  end
  resources :chat_users, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
