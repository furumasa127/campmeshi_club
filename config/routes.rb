Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"

  scope module: 'public' do
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    resources :customers, only: [:show, :edit, :update] do
      get :likes, on: :collection
    end
    resources :recipes, only: [:new, :create, :index, :show, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end
    resources :genres, only: [:index]
    get '/genre/search' => 'searches#genre_search'
    get "/search", to: "searches#search"
  end

  namespace :admin do
    get "/" => "homes#top"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :destroy]
    resources :recipes, only: [:index, :destroy]
  end

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
