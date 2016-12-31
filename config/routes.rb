Rails.application.routes.draw do
  get 'sessions/destroy'

  get 'home/index'
  get 'auth/:provider/callback', to: 'login#authenticate'
  get 'login', to: 'login#index'
  get 'logout', to: 'sessions#destroy'

  root 'home#index'
end
