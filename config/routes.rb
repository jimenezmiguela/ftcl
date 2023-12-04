Rails.application.routes.draw do
  root(:to => 'users#index')

  resources(:users)
  resources(:bills)
  resources :measures, only: :index
  get '/measures' , to: 'measures#index'
  post '/measures', to: 'measures#index'
  resources :texts, only: :index
  get '/texts' , to: 'texts#index'
  post '/texts', to: 'texts#index'
end
