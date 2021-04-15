class Room < ApplicationRecord

  have_many :room_users
  have_many :users, through: :room_users

end
