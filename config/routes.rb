# frozen_string_literal: true

Rails.application.routes.draw do
  resources :events
  resources :orgs
  resources :users
  root to: 'application#index'

  # Auth & Sessions
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'

  # Orgs
  post '/orgs/new/fb' => 'orgs#new_from_fb'
end
