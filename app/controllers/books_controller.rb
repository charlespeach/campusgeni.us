class BooksController < ApplicationController
  require 'yaml' #for when i extract
  require 'vacuum'
 
  before_filter :authenticate_user!, only: [:create, :make_user_login]

  def index
  	user = User.find(params[:user_id])
  	@books = user.books.find(:all)
  end

  def show

  end

  def create
    if current_user.books.build(params[:book]).save
	  redirect_to dashboard_path, notice: "added book"
	else
	  redirect_to :back, notice: "shit didn't work son <%= p #{params[:book]}"
    end
  end

  def search
	isbn_query = params.fetch(:search, '')
	strip_hyphen!(isbn_query)

	unless (isbn_query.size == 10 || isbn_query.size == 13)
		flash[:notice] = "10/13 Digit ISBN Please."
		redirect_to root_url
		return
	end

	@user = current_user
	@book = AmazonSearch.new("#{isbn_query}").amazon_request

	if @user 
		@path = [@user, @book]
	else
		@path = @book 
	end
  end

  def all_books
	@books = Book.all
  end

  def make_user_login
  end

  private 

  def strip_hyphen!(string)
	string.gsub!("-", "")
  end

end
