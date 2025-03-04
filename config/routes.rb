Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  },defaults: { format: :json }
  
  devise_for :event_organizers, controllers: {
    sessions: 'event_organizers/sessions',
    registrations: 'event_organizers/registrations'
  },defaults: { format: :json }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :events, only: [:index, :show, :create, :update, :destroy]
  resources :events, only: [] do
    resources :bookings, only: [:create, :index, :show, :destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
