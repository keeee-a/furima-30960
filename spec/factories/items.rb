FactoryBot.define do
  factory :item do
    name { 'aiueo' }
    category_id { 2 }
    price { 500 }
    explanation { 'kakikukeko' }
    product_condition_id { 2 }
    burden_shipping_id { 2 }
    shipping_area_id { 2 }
    days_to_ship_id { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/image_ex.png'), filename: 'image_ex.png')
    end
  end
end
