require 'rails_helper'

RSpec.describe Deposit, type: :model do
  it 'is not valid without a sender' do
    deposit = Deposit.new(stock_id: nil)
    expect(deposit).to_not be_valid
  end

  it 'is not valid deposit with amount less than 19_999' do
    deposit = Deposit.new(amount: 15_000)
    expect(deposit).to_not be_valid
  end

  it 'is not valid deposit with amount less than sender balance' do
    deposit = Deposit.new(amount: 999_999_999_999_999)
    expect(deposit).to_not be_valid
  end
end
