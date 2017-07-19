Rails.application.routes.draw do
  root 'pages#index'
  resources :rubrics
  resources :clients do
    resources :requests
  end
end
