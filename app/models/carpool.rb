class Carpool < ActiveRecord::Base
  attr_accessible :driver_id

  belongs_to :driver, class_name: "User" # Single Driver per Carpool

  has_many :carpool_riders, class_name: "CarpoolRider"
  has_many :riders, through: :carpool_riders, class_name: "User"
end
