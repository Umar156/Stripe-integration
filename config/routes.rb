Rails.application.routes.draw do
  root 'home#index'
  resources :workshops, only: %i[index show]
  post "/bookings/create", to: "bookings#create"
end
