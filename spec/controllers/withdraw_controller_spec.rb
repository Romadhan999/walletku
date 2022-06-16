require 'rails_helper'

RSpec.describe WithdrawsController, type: :controller do
  let(:create_withdraw) do
    FactoryBot.create(:withdraw)
  end

  let(:stock) do
    FactoryBot.create(:stock)
  end

  let(:insufficient_stock) do
    FactoryBot.create(:stock, account_number: nil)
  end

  let(:sender) do
    FactoryBot.create(:user)
  end

  let(:valid_attributes) do
    {
      amount: 50_000,
      stock_id: stock.id,
      user_id: sender.id
    }
  end

  let(:invalid_attributes) do
    {
      amount: 1000,
      stock_id: insufficient_stock.id,
      user_id: sender.id
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Withdraw' do
        expect do
          post :create, params: { withdraw: valid_attributes }
        end.to change(Withdraw, :count).by(1)
      end

      it 'sender balance decreases' do
        current_balance = sender.balance

        post :create, params: { withdraw: valid_attributes }
        expect(sender.balance < current_balance).to eq(true)
      end
    end

    context 'with invalid params' do
      it "returns a errors response (ex: 'Amount minimum is Rp. 50.000')" do
        expect do
          post :create, params: { withdraw: invalid_attributes }
        end.to change(Withdraw, :count).by(0)
      end
    end
  end
end
