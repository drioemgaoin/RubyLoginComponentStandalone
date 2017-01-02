Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  devise_for :users, :controllers => {
    omniauth_callbacks: 'omniauth_callbacks'
  }, path_names: { sign_in: "login", sign_out: "logout" }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
end
