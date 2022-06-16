class WithdrawsController < ApplicationController
  def create
    @withdraw = Withdraw.new(withdraw_params)

    if @withdraw.save
      redirect_to root_url, notice: 'Withdraw was successfully created.'
    else
      redirect_to root_url, alert: "Withdraw was failed #{@withdraw.errors.full_messages.to_sentence}."
    end
  end

  private

  def withdraw_params
    params.require(:withdraw).permit(:user_id, :stock_id, :amount)
  end
end
