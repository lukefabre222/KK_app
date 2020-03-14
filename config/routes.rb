Rails.application.routes.draw do
  root 'static_pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/edit-basic-info/:id', to: 'users#edit_basic_info', as: :basic_info
  patch '/update_basic_info', to: 'users#update_basic_info'
  post '/users/:id/attendances/new', to: 'attendances#create'
  
  resources :users do
    resources :attendances
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
