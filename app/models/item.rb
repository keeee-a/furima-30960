class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :burden_shipping
  belongs_to :shipping_area
  belongs_to :days_to_ship
  with_options presence: true do
    validates :name
    validates :price
    validates :explanation
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :product_condition_id
      validates :burden_shipping_id
      validates :shipping_area_id
      validates :days_to_ship_id
    end
  end
  validates :price, numericality: {greater_than: 299, less_than: 10000000}, format: {with: /\A[0-9]+\z/}
  validate :image_attached?

  private
  
  def image_attached?
    if !image.attached?
      image.purge
      errors.add(:image, 'は必須です')
    end
  end
end
