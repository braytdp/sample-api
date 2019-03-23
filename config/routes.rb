Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :events
  resources :visits

  get 'users/identification/:identification', to: 'users#identification'
end
