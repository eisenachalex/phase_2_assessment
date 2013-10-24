class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.+@.+\..+/, message: "Invalid email"}

  has_secure_password 

  has_many :created_events, class_name: "Event"
  has_many :event_attendances 
  has_many :attended_events, through: :event_attendances, source: :user
end
