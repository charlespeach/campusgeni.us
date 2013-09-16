class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string :title
      t.string :author
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
