FactoryBot.define do
  factory :withdraw do |f|
    association :sender, factory: :user
    association :receiver, factory: :stock

    f.amount { Faker::Number.number(digits: 6) }
    f.user_id { 1 }
    f.stock_id { 2 }
  end
end
