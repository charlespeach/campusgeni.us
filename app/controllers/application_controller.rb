class ApplicationController < ActionController::Base
  require 'open-uri'
  require 'json'

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def search_isbn(isbn)
  	url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}"
  	result = JSON.parse(open(url).read)
  	result 
  end
end
