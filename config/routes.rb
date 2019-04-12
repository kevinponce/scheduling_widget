Rails.application.routes.draw do
  resources :appointments, only: [:index, :create] do
    resources :steps, only: [:show, :update], controller: 'appointments/steps'
  end

  root to: 'appointments#index'
end
