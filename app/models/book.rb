class Book < ActiveRecord::Base

  attr_accessible :author, :course_id, :isbn, :title, :user_id, :course_id, :amazon_url,
  				  :small_image_url, :medium_image_url, :large_image_url, :publisher,
  				  :edition, :number_of_pages, :days

  # validates :author, :isbn, :title, :amazon_url, :small_image_url, :medium_image_url, :large_image_url,
  # 			:publisher, :number_of_pages, :days, presence: true
  validates :days, inclusion: 1..7

  belongs_to :user
  has_and_belongs_to_many :courses
end
