class SectionCourseJoin < ActiveRecord::Migration

  def change
	  add_column :sections, :course_id, :integer
	  add_column :courses, :section_id, :integer
	  add_index :sections, :course_id
  end


end

