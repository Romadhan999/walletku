FactoryBot.define do
  factory :transaction_deposit, class: Transaction do |f|
    association :transactable, factory: :deposit
    association :sourceable, factory: :user

    f.code { 'DP00000000014' }
    f.transactable_type { 'Deposit' }
    f.transactable_id { 15 }
    f.sourceable_type { 'User' }
    f.sourceable_id { 1 }
    f.action { 'receiver' }
  end

  factory :transaction_withdraw, class: Transaction do |f|
    association :transactable, factory: :withdraw
    association :sourceable, factory: :stock

    f.code { 'WD00000000006' }
    f.transactable_type { 'Withdraw' }
    f.transactable_id { 7 }
    f.sourceable_type { 'Stock' }
    f.sourceable_id { 1 }
    f.action { 'receiver' }
  end

  factory :transaction_transfer, class: Transaction do |f|
    association :transactable, factory: :transfer
    association :sourceable, factory: :user

    f.code { 'TF00000000007' }
    f.transactable_type { 'Transfer' }
    f.transactable_id { 8 }
    f.sourceable_type { 'User' }
    f.sourceable_id { 2 }
    f.action { 'receiver' }
  end
end
