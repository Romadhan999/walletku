require 'rails_helper'

describe RecalculateBalanceService do
  let(:create_deposit) do
    FactoryBot.create(:transaction_deposit)
  end

  let(:create_transfer) do
    FactoryBot.create(:transaction_transfer)
  end

  let(:create_withdraw) do
    FactoryBot.create(:transaction_withdraw)
  end

  let(:stock) do
    FactoryBot.create(:stock)
  end

  let(:wallet) do
    FactoryBot.create(:user)
  end

  describe 'calculate balance' do
    it 'transaction deposit' do
      deposit = create_deposit
      Transactions::RecalculateBalanceService.new(transaction_id: deposit.id).call
      expect(deposit.transactable.amount.to_f).to eq(250_000.0)
    end

    it 'account got top up and calculate balance' do
      deposit = create_deposit
      Transactions::RecalculateBalanceService.new(transaction_id:).call
      expect(deposit.transactable.receiver.balance.to_f).to eq(250_000.0)
    end

    it 'transaction transfer sender got refuction balance' do
      transfer = FactoryBot.create(:transaction_transfer)
      Transactions::RecalculateBalanceService.new(transaction_id:).call
      expect(transfer.sourceable.balance.to_f).to eq(250_000.0)
    end
  end
end
