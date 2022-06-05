class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :rooms, dependent: :destroy
  has_many :resevations, dependent: :destroy
  attachment :profile_image

  validates :name, :email, presence: true
end
