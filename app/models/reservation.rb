require 'date'
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :person, numericality: true

  def start_end_check
    errors.add(:end_date, 'はチェックイン日より前の日付で登録できません') unless
    start_date < end_date
  end

  def now_start_check
    errors.add(:start_date, 'は今日より前の日付で登録できません') unless
    start_date > Date.today
  end

  def total_price
    self.room.price * (end_date - start_date).to_i * guests_num
  end
  
end