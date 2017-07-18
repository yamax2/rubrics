Rails.application.routes.draw do
  root 'pages#index'
  resources :clients do
    resources :requests
  end
end
