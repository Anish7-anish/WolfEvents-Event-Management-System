Rails.application.routes.draw do
  resources :events
  resources :event_tickets
  resources :rooms
  resources :reviews
  root 'home#index'
  resources :attendees
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "attendees#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
