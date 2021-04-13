Rails.application.routes.draw do
  devise_for :buyers
  devise_for :sellers, controllers: {
    registrations: 'registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
