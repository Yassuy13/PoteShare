require 'date'
class ReserveForm 

  attr_accessor :startdate, :enddate, :num

  validates :startdate, presence: true
  validates :enddate, presence: true, length: { in: 1..255 }
  validates :num, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate :start_end_check
  validate :now_start_check
  
  def start_end_check
    unless startdate.to_date < enddate.to_date
      errors.add(:enddate, 'はチェックイン日より前の日付で登録できません')
    end
  end

  def now_start_check
    errors.add(:startdate, 'は今日より前の日付で登録できません') unless
    startdate.to_date > Date.today
  end
end