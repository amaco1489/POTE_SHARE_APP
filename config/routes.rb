Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_scope :user do
    get "users/show", to: "users/registrations#show"
  end

  root 'top#index'
  get 'top/index'

  resources :reservations , only: [:index, :new, :create, :show] do
    collection do
      post "confirm"
    end
  end
  
  resources :rooms, only: [:index, :new, :create, :show] do
    collection do
      get "post_room"
      get "search_tokyo"
      get "search_osaka"
      get "search_kyoto"
      get "search_sapporo"
      get "search"
      get "area_search"
    end
  end

end
