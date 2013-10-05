class AddColumnsToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :amazon_url, :string
  	add_column :books, :small_image_url, :string
  	add_column :books, :medium_image_url, :string
  	add_column :books, :large_image_url, :string
  	add_column :books, :publisher, :string
  	add_column :books, :edition, :string
  	add_column :books, :number_of_pages, :integer
  end
end

