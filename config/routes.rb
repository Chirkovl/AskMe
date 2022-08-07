Rails.application.routes.draw do
  root to: 'questions#index'
   post '/session', to: 'sessions#create'
   get '/session/new', to: 'sessions#new'
   delete '/session', to: 'sessions#destroy'
  # patch '/questions/:id', to: 'questions#update'
  # delete '/questions/:id', to: 'questions#destroy'
  resources :questions
  # resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create]
end

