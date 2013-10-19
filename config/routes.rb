CampusgeniUs::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end  

  root :to => "home#index"
  
  devise_for :users

  resources :users do 
    resources :books
  end

  resources :sections
  resources :courses

  match 'search' => 'books#search', :as => 'book_search', :via => :get
  match 'books' => 'books#all_books', via: :get
end
