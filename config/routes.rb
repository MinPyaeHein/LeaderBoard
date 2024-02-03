# config/routes.rb

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :members, only: [:index, :create]
      resources :event_types, only: [:index, :create]
      resources :events, only: [:index, :create]
      resources :score_types, only: [:index, :create]
      # Add other resourceful routes if needed
    end
  end
end
