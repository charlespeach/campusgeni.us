class AddColumnsAndJoinTable < ActiveRecord::Migration
 def change

 	add_column :carpool_riders, :carpool_id, :integer
 	add_column :carpool_riders, :rider_id, :integer 

 	add_column :carpools, :driver_id, :integer 
 end
end
