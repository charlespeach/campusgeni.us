class CreateBooksCourseJoinTable < ActiveRecord::Migration
def self.up
  create_table 'books_courses', :id => false do |t|
    t.column :book_id, :integer
    t.column :course_id, :integer
  end
end

  def down
  	drop_table 'books_courses'
  end
end

