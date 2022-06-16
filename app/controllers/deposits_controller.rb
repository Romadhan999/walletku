class DepositsController < ApplicationController
  def create
    @deposit = Deposit.new(deposit_params)

    if @deposit.save
      redirect_to root_url, notice: 'Top Up was successfully created.'
    else
      redirect_to root_url, alert: "Top Up was failed #{@deposit.errors.full_messages.to_sentence}."
    end
  end

  private

  def deposit_params
    params.require(:deposit).permit(:user_id, :stock_id, :amount)
  end
end
