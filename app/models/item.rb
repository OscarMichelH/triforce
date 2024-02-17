class Item < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :carts
  has_many :sales, dependent: :delete_all
  has_many :discounts
  has_many_attached :images
  validate :image_type

  def thumbnail input
    return self.images[input].variant(resize: '300x300').processed
  end

  def image_type
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png image/webp image/jpg/webp'))
        errors.add(:images, 'needs to be valid format')
      end
    end
  end
end
