FactoryBot.define do
  factory :deposit do |f|
    association :sender, factory: :stock
    association :receiver, factory: :user

    f.amount { Faker::Number.number(digits: 6) }
    f.stock_id { 1 }
    f.user_id { 2 }
  end
end
