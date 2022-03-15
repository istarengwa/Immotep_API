Rails.application.routes.draw do
  resources :projects do 
    resources :housings 
  end
  resources :housings
  devise_for :users,
            controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                passwords: 'users/passwords'
            },
            defaults: { format: :json }
  get '/member-data', to: 'members#show'
  resource :passwords, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end