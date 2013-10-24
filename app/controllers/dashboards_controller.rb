class DashboardsController < ApplicationController
  def show
  	@books = current_user.books.find(:all)
  end
end
