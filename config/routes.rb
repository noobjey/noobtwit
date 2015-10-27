Rails.application.routes.draw do
  root 'session#new'

  # Special login path for OmniAuth
  # todo: link to reference
  get '/auth/twitter', as: :login

  get '/auth/twitter/callback', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  get 'dashboard', to: 'dashboard#index'

  resource :user, only: [:update]
end
