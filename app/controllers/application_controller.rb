class ApplicationController < ActionController::Base
  # require 'open-uri'
  # require 'json'
  before_filter :store_location

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" &&
      !request.xhr?) # don't store ajax calls
    session[:previous_url] = request.referer
  end
end

def after_sign_in_path_for(resource)
  session[:previous_url] || super
end

  # def search_isbn(isbn)
  # 	url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}"
  # 	result = JSON.parse(open(url).read)
  # 	result
  # end

end
