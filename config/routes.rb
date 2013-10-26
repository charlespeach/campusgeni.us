CampusgeniUs::Application.routes.draw do
  
  match '/dashboard' => 'dashboards#show', as: 'dashboard'

  authenticated :user do
    root :to => 'dashboards#show'
  end  

  root :to => "home#index"
  
  devise_for :users

  resources :users do 
    resources :books
  end
  
  resource :dashboard, only: [:show]
  resources :sections
  resources :courses

  match 'search' => 'books#search', :as => 'book_search', :via => :get
  match 'site_search' => 'books#site_search', :as => 'site_search', via: :get
  match 'books' => 'books#all_books', via: :get
  match 'books' => 'books#make_user_login', via: :post
end
