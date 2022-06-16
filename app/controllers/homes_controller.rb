class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index; end

  def wallet_history
    @user = User.find(params[:user_id])
  end
end
