class CreateCarpools < ActiveRecord::Migration
  def change
    create_table :carpools do |t|

      t.timestamps
    end
  end
end
