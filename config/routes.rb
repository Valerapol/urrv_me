Rails.application.routes.draw do
  devise_for :users
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :airports
    resources :users, only: [:index, :edit, :show, :update]
    root "home#index", as: 'home', via: :all
    get 'home/index'
    get "privacy_policy", to: "home#privacy_policy"
  end
end
