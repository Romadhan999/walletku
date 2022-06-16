require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  let(:create_transfer) do
    FactoryBot.create(:transfer)
  end

  let(:sender) do
    FactoryBot.create(:user)
  end

  let(:receiver) do
    FactoryBot.create(:user)
  end

  let(:valid_attributes) do
    {
      amount: 50,
      sender_id: sender.id,
      receiver_id: receiver.id
    }
  end

  let(:invalid_attributes) do
    {
      amount: 1000,
      sender_id: account.id,
      receiver_id: receiver.id
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Transfer' do
        expect do
          post :create, params: { transfer: valid_attributes }
        end.to change(Transfer, :count).by(1)
      end

      it 'receiver balance increases' do
        current_balance = receiver.balance

        post :create, params: { transfer: valid_attributes }
        expect(receiver.balance > current_balance).to eq(true)
      end

      it 'sender balance decreases' do
        current_balance = sender.balance

        post :create, params: { transfer: valid_attributes }
        expect(sender.balance < current_balance).to eq(true)
      end
    end

    context 'with invalid params' do
      it "returns a errors response (ex: 'Amount minimum is Rp. 10.000')" do
        expect do
          post :create, params: { transfer: invalid_attributes }
        end.to change(Transfer, :count).by(0)
      end
    end
  end
end
