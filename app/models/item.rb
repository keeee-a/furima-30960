class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  with_options null:false do
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
  validates :price, numericality: {greater_than: 300, less_than: 9999999}, format: {with: /\A[0-9]+\z/}
end
