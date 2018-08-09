Rails.application.routes.draw do
  resources :cryptos
  root 'pages#home'

  post '/unit', to: 'cryptos#unit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
