class Section < ActiveRecord::Base
  attr_accessible :title, :course_id

  has_many :courses
end
