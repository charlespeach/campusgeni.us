class BooksController < ApplicationController

	def search
		@tempbook = Book.new
		@isbn = params[:search]

		if result = search_isbn(@isbn)
			@tempbook.title = result['items'][0]['volumeInfo']['title']
			@tempbook.author = result['items'][0]['volumeInfo']['authors'][0]

		else
			flash[:notice] = "Sorry ISBN#:#{@isbn} was not found" 
			redirect_to :back

		end
	end

end
