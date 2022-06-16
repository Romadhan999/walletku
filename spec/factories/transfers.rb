FactoryBot.define do
  factory :transfer do |f|
    association :sender, factory: :user
    association :receiver, factory: :user

    f.amount { Faker::Number.number(digits: 6) }
    f.sender_id { 1 }
    f.receiver_id { 2 }
  end
end
