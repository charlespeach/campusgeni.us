class AmazonSearch

  def initialize(isbn)
  	@isbn = isbn
  end

  def amazon_request
    req = Vacuum.new
		  .configure(
		    aws_access_key_id:     'AKIAIYOWFSJWSGLL7FZQ',
		    aws_secret_access_key: '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',
		    associate_tag:         'toen-20'
		  )

    amazon_api_params = { 'Operation'   => 'ItemLookup',
		  			 		  'ResponseGroup' => 'Large',
           			          'SearchIndex' => 'All',
           			          'IdType' => 'ISBN',
           			          'ItemId' => "#{@isbn}" }

    amazon_response = req.get(query: amazon_api_params)
    response = Response.new(amazon_response).to_h

    book = Book.new

    if response['ItemLookupResponse']['Items']['Item'][0].nil?
    	book.author           = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Author']
    	book.publisher        = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Publisher']
    	book.title            = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Title']
    	book.isbn             = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['ISBN']
    	book.amazon_url       = response['ItemLookupResponse']['Items']['Item']['DetailPageURL']
    	book.small_image_url  = response['ItemLookupResponse']['Items']['Item']['SmallImage']['URL']
    	book.medium_image_url = response['ItemLookupResponse']['Items']['Item']['MediumImage']['URL']
    	book.large_image_url  = response['ItemLookupResponse']['Items']['Item']['LargeImage']['URL']
    	book.edition          = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Edition']
    	book.number_of_pages  = response['ItemLookupResponse']['Items']['Item']['ItemAttributes']['NumberOfPages']
    else
    	book.author           = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Author']
    	book.publisher        = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Publisher']
    	book.title            = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Title']
    	book.isbn             = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['ISBN']
    	book.amazon_url       = response['ItemLookupResponse']['Items']['Item'][0]['DetailPageURL']
    	book.small_image_url  = response['ItemLookupResponse']['Items']['Item'][0]['SmallImage']['URL']
    	book.medium_image_url = response['ItemLookupResponse']['Items']['Item'][0]['MediumImage']['URL']
    	book.large_image_url  = response['ItemLookupResponse']['Items']['Item'][0]['LargeImage']['URL']
    	book.edition          = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['Edition']
    	book.number_of_pages  = response['ItemLookupResponse']['Items']['Item'][0]['ItemAttributes']['NumberOfPages']
    end

    book
  end
end
