Rails.application.routes.draw do

  resources :events
  resources :event_tickets
  resources :rooms
  resources :reviews
  resources :booking_histories
  root 'home#index'
  resources :attendees
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'attendees#new', as: 'signup'
  post 'signup', to: 'attendees#create', as: 'Register'
  get 'login', to: "sessions#new", as: 'login'
  # get 'logout', to: "sessions#destroy", as: 'logout'
  get '/search_attendees', to: 'attendees#search', as: 'search_attendees'
  delete 'logout', to: 'sessions#destroy', as: :logout
  delete 'account', to: 'attendees#destroy', as: 'delete_account'
  get 'rooms/:id/details', to: 'rooms#details', as: 'room_details'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
