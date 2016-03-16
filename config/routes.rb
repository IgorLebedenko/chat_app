Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  match '/signup', to: 'users#new', via: 'get'
end
