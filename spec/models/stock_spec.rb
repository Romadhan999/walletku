require 'rails_helper'

RSpec.describe Stock, type: :model do
  it 'is not valid without a account_number' do
    stock = Stock.new(account_number: nil)
    expect(stock).to_not be_valid
  end

  describe 'validates uniqueness of account_number' do
    subject { FactoryBot.build(:stock) }
    it { should validate_uniqueness_of(:account_number) }
  end
end
