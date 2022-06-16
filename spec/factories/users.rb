FactoryBot.define do
  password = Faker::Internet.password

  factory :user do |f|
    f.email { Faker::Internet.email }
    f.fullname { Faker::Name.name }
    f.phone_number { Faker::Number.number(digits: 12) }
    f.username { Faker::Internet.username }
    f.account_number { Faker::Number.number(digits: 11) }
    f.balance { Faker::Number.number(digits: 7) }
    f.password { [password] }
    f.password_confirmation { [password] }
  end
end
