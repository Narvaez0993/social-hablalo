Rails.application.routes.draw do

  #endpoints Comments
  resources :comments
  
  #endpoints posts
  resources :posts


  #manejo de usuarios
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
