class Form
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token, :price

  with_options presence: true do
    #with_options foreign_key: true do
      validates :user_id
      validates :item_id
    #end
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    StreetAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end

end
