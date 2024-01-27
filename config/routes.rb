Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v0 do
      resources :subscriptions, only: [:create, :destroy]
    end
  end
end
