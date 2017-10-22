Rails.application.routes.draw do
  resources :statuses
  resources :calendars
  resources :shares do
    member do
      put 'change'
    end
  end

  get 'users/index'

  get 'users/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"

  get 'before_mounth' => 'calendars#index', as: :before_mounth
end
