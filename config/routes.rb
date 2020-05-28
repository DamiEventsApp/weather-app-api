Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events, only: %i[ create update destroy index ]
  get '/search_events', to: 'search#search_events'
  post '/auth/login', to: 'authentication#login'
end
