Rails.application.routes.draw do
  get 'chatbot/respond'

  post 'analyze', to: 'site_analysis#analyze'
  post 'chatbot/respond', to: 'chatbot#respond'
  post 'seo_audit/analyze', to: 'seo_audit#analyze'

  resources :contact_forms, only: [:create, :index]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
