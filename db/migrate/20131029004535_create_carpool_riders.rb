class CreateCarpoolRiders < ActiveRecord::Migration
  def change
    create_table :carpool_riders do |t|

      t.timestamps
    end
  end
end
