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

end
