class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  with_options presence: true do
    validates :check_in
    validates :check_out
    validates :total_gests, numericality: {greater_than: 0}
  end

  validate :today_before_check_in
  validate :check_in_before_check_out

  def today_before_check_in
    return if check_in.blank?
    if check_in < Date.today
      errors.add :check_in, "は今日以降を選択して下さい"
    end
  end
  
  def check_in_before_check_out
    return if check_in.blank? || check_out.blank?
    if check_in == check_out || check_out < check_in 
      errors.add :check_out, "は宿泊当日日以降を選択して下さい"
    end
  end

  def total_days
    (check_out - check_in).to_i
  end

  def total_price
    total_days * total_gests * room.price
  end

end
