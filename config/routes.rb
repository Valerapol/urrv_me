Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :airports
    root "home#index", as: 'home', via: :all
    get 'home/index'
    get "privacy_policy", to: "home#privacy_policy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
