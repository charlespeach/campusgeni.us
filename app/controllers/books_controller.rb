class BooksController < ApplicationController
  require 'yaml' #for when i extract
  require 'vacuum'

  before_filter :authenticate_user!, only: [:create]

  def index
  	user = User.find(params[:user_id])
  	@books = user.books.find(:all)
  end

  def show

  end

  def create

    if current_user.books.build(params[:book]).save
	  redirect_to user_books_path, notice: "added book"
	else
	  redirect_to :back, notice: "shit didn't work son <%= p #{params[:book]}"

    end
  end

  def search
		################## GOOGLE API #######################################
		#@tempbook = Book.new
		#@isbn = params[:search]

		#if result = search_isbn(@isbn)
		#	@tempbook.title = result['items'][0]['volumeInfo']['title']
		#	@tempbook.author = result['items'][0]['volumeInfo']['authors'][0]

		#else
			#flash[:notice] = "Sorry ISBN#:#{@isbn} was not found" 
			#redirect_to :back

		#end
		#####################################################################

		################# AMAZON API ########################################
		#REMEMBER TO EXTRACT PRIVATE INFO TO ENV VARIABLES 
		req = Vacuum.new
		  .configure(
		    aws_access_key_id:     'AKIAIYOWFSJWSGLL7FZQ',
		    aws_secret_access_key: '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',
		    associate_tag:         'toen-20'
		  )

		isbn_query = params.fetch(:search, '')
	  	strip_hyphen!(isbn_query)


		unless (isbn_query.size == 10 || isbn_query.size == 13)
			flash[:notice] = "10/13 Digit ISBN Please."
			redirect_to root_url
			return
		end

		@user = current_user
		@book = Book.new

		amazon_api_params = { 'Operation'   => 'ItemLookup',
		  			 		  'ResponseGroup' => 'Large',
           			          'SearchIndex' => 'All',
           			          'IdType' => 'ISBN',
           			          'ItemId' => "#{isbn_query}" }

		amazon_response = req.get(query: amazon_api_params)
		response = Response.new(amazon_response).to_h

		if response['ItemLookupResponse']['Items']['Item'][0].nil?
			@book.author           = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Author']
			@book.publisher        = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Publisher']
			@book.title            = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Title']
			@book.isbn             = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['ISBN']
			@book.amazon_url       = response['ItemLookupResponse']['Items']['Item']['DetailPageURL']
			@book.small_image_url  = response['ItemLookupResponse']['Items']['Item']['SmallImage']['URL']
			@book.medium_image_url = response['ItemLookupResponse']['Items']['Item']['MediumImage']['URL']
			@book.large_image_url  = response['ItemLookupResponse']['Items']['Item']['LargeImage']['URL']
			@book.edition          = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Edition']
			@book.number_of_pages  = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['NumberOfPages']
		else
			@book.author           = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Author']
			@book.publisher        = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Publisher']
			@book.title            = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Title']
			@book.isbn             = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['ISBN']
			@book.amazon_url       = response['ItemLookupResponse']['Items']['Item'][0]['DetailPageURL']
			@book.small_image_url  = response['ItemLookupResponse']['Items']['Item'][0]['SmallImage']['URL']
			@book.medium_image_url = response['ItemLookupResponse']['Items']['Item'][0]['MediumImage']['URL']
			@book.large_image_url  = response['ItemLookupResponse']['Items']['Item'][0]['LargeImage']['URL']
			@book.edition          = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Edition']
			@book.number_of_pages  = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['NumberOfPages']
		end
	end

	def all_books
		@books = Book.all
	end

	private 

	def strip_hyphen!(string)
		string.gsub!("-", "")
	end

end
