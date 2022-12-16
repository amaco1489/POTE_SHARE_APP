class Room < ApplicationRecord

  belongs_to :user
  has_many :reservation, dependent: :destroy

  mount_uploader :room_img, ImageUploader

  with_options presence: true do
    validates :room_name
    validates :room_introduction
    validates :price
    validates :address
    validates :room_img
  end

  validate :min_price

  def min_price
    if price.to_i < 1000
      return if price.blank?
      errors.add :price, "は￥１０００以上にしてください"
    end
  end

end
