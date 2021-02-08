class Form
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token, :price

  with_options presence: true do
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/}
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city, format: {with: /\A[ぁ-んァ-ン一-龥々]/}
    validates :address, format: {with: /\A[ぁ-んァ-ン一-龥々1-9]/}
    validates :phone_number, format: {with: /\A[0-9]+\z/}, length: {maximum: 11}
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    StreetAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end

end
