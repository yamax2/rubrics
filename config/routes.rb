Rails.application.routes.draw do
  root 'pages#index'
  resources :clients
end
