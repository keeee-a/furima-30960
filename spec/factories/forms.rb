FactoryBot.define do
  factory :form do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {"123-4567"}
    prefecture_id {2}
    city {"横浜市"}
    address {"青山1-1-1"}
    phone_number {"09012345678"}
    building {"青山マンション"}
  end
end