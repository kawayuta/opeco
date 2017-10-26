Rails.application.routes.draw do
  resources :calendars do
    member do
      put 'seiri_kikan'
    end
  end
  resources :shares do
    member do
      put 'change'
    end
  end


  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "calendars#index"

  get 'before_mounth' => 'calendars#index', as: :before_mounth
end
