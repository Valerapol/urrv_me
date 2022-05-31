Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
  }

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :documents
    resources :airports
    resources :users, only: [:index, :edit, :show, :update]
    root "home#index", as: 'home', via: :all
    get 'home/index'
    get "privacy_policy", to: "home#privacy_policy"
    get "tos", to: "home#tos"
  end
end
