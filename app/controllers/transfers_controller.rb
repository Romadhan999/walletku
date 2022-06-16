class TransfersController < ApplicationController
  def create
    @transfer = Transfer.new(transfer_params)

    if @transfer.save
      redirect_to root_url, notice: 'Transfer was successfully created.'
    else
      redirect_to root_url, alert: "Transfer was failed #{@transfer.errors.full_messages.to_sentence}."
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:sender_id, :receiver_id, :amount, :note)
  end
end
