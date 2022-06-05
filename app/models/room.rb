class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  attachment :room_image
  validates :title, presence: true
  validates :address,  presence: true
  validates :price, numericality: true
end