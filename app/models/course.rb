class Course < ActiveRecord::Base
  attr_accessible :title, :section_id, :book_id
  belongs_to :section
  has_and_belongs_to_many :books

end
