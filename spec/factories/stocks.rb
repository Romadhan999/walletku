FactoryBot.define do
  factory :stock do |f|
    association :user

    f.account_number { Faker::Number.number(digits: 11) }
    f.name { Faker::Name.name }
    f.code { Faker::Number.number(digits: 2) }
    f.balance { Faker::Number.number(digits: 9) }
    f.user_id { 2 }
  end
end
