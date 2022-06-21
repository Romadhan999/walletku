require 'rails_helper'

RSpec.describe Withdraw, type: :model do
  it 'is not valid without a receiver' do
    withdraw = Withdraw.new(stock_id: nil)
    expect(withdraw).to_not be_valid
  end

  it 'is not valid withdraw with amount less than 49_999' do
    withdraw = Withdraw.new(amount: 25_000)
    expect(withdraw).to_not be_valid
  end

  it 'is not valid withdraw with amount less than sender balance' do
    withdraw = Withdraw.new(amount: 999_999_999_999_999)
    expect(withdraw).to_not be_valid
  end
end
