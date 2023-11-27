Rails.application.routes.draw do
  root(:to => 'users#index')

  resources(:users)
  resources(:bills)
  resources :measures, only: :index
  resources :texts, only: :index
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
