Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :airports
    resources :users, only: [:index, :edit, :show, :update]
    root "home#index", as: 'home', via: :all
    get 'home/index'
    get "privacy_policy", to: "home#privacy_policy"
    get "tos", to: "home#tos"
  end
end
