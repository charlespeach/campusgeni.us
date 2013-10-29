class CarpoolRider < ActiveRecord::Base
  attr_accessible :carpool_id, :rider_id

  belongs_to :carpool, class_name: "Carpool"
  belongs_to :rider, class_name: "User"
  
  # Schema:
  # carpool_id
  # rider_id
end