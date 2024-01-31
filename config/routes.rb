Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    #  member do
    #    get '/discover', to: "discover#show"
    #  end
    # resources :discover
    get "/discover", to: "discover#show"
    resources :movies, controller:'user_movies'

  end

# get "/discover", to: "discover#show"
end
