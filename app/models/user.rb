class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :encrypted_password
  
  has_many :books

  has_many :carpools_driven, class_name: "Carpool", foreign_key: "driver_id"
 
  has_many :carpool_riders, class_name: "CarpoolRider"
  has_many :carpools_ridden, through: :carpool_riders, class_name: "Carpool"
  
end
