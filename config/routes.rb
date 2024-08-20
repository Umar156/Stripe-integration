Rails.application.routes.draw do
  root 'home#index'
  resources :workshops, only: %i[index show]
end
