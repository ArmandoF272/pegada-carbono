Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  root "home#index"

  resources :calculations do
    member do
      patch :save
    end
  end

  resource :report, only: [:show]
  resources :tips, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check
end
