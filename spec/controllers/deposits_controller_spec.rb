require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  let(:create_deposit) do
    FactoryBot.create(:deposit)
  end

  let(:stock) do
    FactoryBot.create(:stock)
  end

  let(:insufficient_stock) do
    FactoryBot.create(:stock, account_number: nil)
  end

  let(:receiver) do
    FactoryBot.create(:user)
  end

  let(:valid_attributes) do
    {
      amount: 20_000,
      stock_id: stock.id,
      user_id: receiver.id
    }
  end

  let(:invalid_attributes) do
    {
      amount: 1000,
      stock_id: insufficient_stock.id,
      user_id: receiver.id
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Deposit' do
        expect do
          post :create, params: { deposit: valid_attributes }
        end.to change(Deposit, :count).by(1)
      end

      it 'receiver balance increases' do
        current_balance = receiver.balance

        post :create, params: { deposit: valid_attributes }
        expect(receiver.balance > current_balance).to eq(true)
      end
    end

    context 'with invalid params' do
      it "returns a errors response (ex: 'Amount minimum is Rp. 20.000')" do
        expect do
          post :create, params: { deposit: invalid_attributes }
        end.to change(Deposit, :count).by(0)
      end
    end
  end
end
