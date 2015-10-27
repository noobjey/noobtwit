Rails.application.routes.draw do
  root 'session#new'

  # Special login path for OmniAuth
  # todo: link to reference
  get '/auth/twitter', as: :login

  get '/auth/twitter/callback', to: 'session#create'
end
