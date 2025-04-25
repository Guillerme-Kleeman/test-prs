Rails.application.routes.draw do
  resources :clients, only: %i[index show create update]
  resources :users, only: %i[index show create update destroy] do
    # This route will be available at /users/buscar
    collection do
      get :search, path: "buscar"
    end

    member do
      # This route will be available at /users/:id/activate
      post :activate
      # This route will be available at /users/:id/deactivate
      post :deactivate
    end
  end

  namespace :admin do
    resources :users, only: %i[index show create update destroy] do
      # This route will be available at /admin/users/:id/activate
      post :activate, on: :member
      # This route will be available at /admin/users/:id/deactivate
      post :deactivate, on: :member
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
