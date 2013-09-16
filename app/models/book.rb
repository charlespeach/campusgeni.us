class Book < ActiveRecord::Base
 
  attr_accessible :author, :course_id, :isbn, :title, :user_id, :course_id

  belongs_to :user
  has_and_belongs_to_many :courses 


end

