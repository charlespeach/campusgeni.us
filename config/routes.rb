CampusgeniUs::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :sections
  resources :courses
  resources :books

  match '/search' => 'books#search', :as => 'book_search', :via => :get
end