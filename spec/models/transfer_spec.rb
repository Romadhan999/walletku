require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it 'is not valid without a receiver' do
    transfer = Transfer.new(receiver_id: nil)
    expect(transfer).to_not be_valid
  end

  it 'is not valid transfer with amount less than 9_999' do
    transfer = Transfer.new(amount: 5_000)
    expect(transfer).to_not be_valid
  end

  it 'is not valid transfer with amount less than sender balance' do
    transfer = Transfer.new(amount: 999_999_999_999_999)
    expect(transfer).to_not be_valid
  end
end
