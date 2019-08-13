Rails.application.routes.draw do
  root 'books#index', as: 'home'
  resources :books

  get 'search' => 'pages#search', as: 'search'
  post 'search' => 'pages#query'
end
