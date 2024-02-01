Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    get "/discover", to: "discover#show"
    resources :movies, controller:'user_movies' do
      resources :viewing_party, controller: "viewing_party"
    end
  end

# get "/discover", to: "discover#show"
end
