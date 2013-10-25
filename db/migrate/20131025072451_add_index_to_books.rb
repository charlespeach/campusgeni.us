class AddIndexToBooks < ActiveRecord::Migration
  def change
  	add_index :books, :isbn
  	add_index :books, :title
  end
end
