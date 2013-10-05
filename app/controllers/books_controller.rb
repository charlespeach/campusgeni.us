class BooksController < ApplicationController
	require 'yaml' #for when i extract
	require 'vacuum'

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

		################# AMAZON API ########################################
		#REMEMBER TO EXTRACT PRIVATE INFO TO ENV VARIABLES 
		req = Vacuum.new
		  .configure(
		    aws_access_key_id:     'AKIAIYOWFSJWSGLL7FZQ',
		    aws_secret_access_key: '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',
		    associate_tag:         'toen-20'
		  )

		@isbn = params[:search]
		@book = Book.new

		params = { 'Operation'   => 'ItemLookup',
		  			 'ResponseGroup' => 'Large',
           			 'SearchIndex' => 'All',
           			 'IdType' => 'ISBN',
           			 'ItemId' => '@isbn'

           			  }

		amazon_response = req.get(query: params)
		response = Response.new(amazon_response).to_h


		end
end

# attr_accessible :author, :course_id, :isbn, :title, :user_id, :course_id



# response['ItemLookupResponse']['Items']['Item'][0]['DetailPageURL'] # URL to buy book
#pp response['ItemLookupResponse']['Items']['Item'][0]['SmallImage']['URL'] # Thumbnail
#pp response['ItemLookupResponse']['Items']['Item'][0]['MediumImage']['URL'] # medium SmallImage
#pp response['ItemLookupResponse']['Items']['Item'][0]['LargeImage']['URL'] # large 
#pp response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Author'] # author 
#pp response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Title'] # title 	
#pp response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Publisher'] # publisher
#pp response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Edition'pp response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']] # edition 
#pp response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['NumberOfPages'] #pages 

