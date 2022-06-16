class User < ApplicationRecord
  has_many :stocks
  has_many :transactions, as: :sourceable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :username, :phone_number, :password_confirmation, presence: true
  validates :username, length: { within: 6..20, too_short: 'is too short (minimum is 6 characters)',
                                 too_long: 'is too long (maximum is 25 characters)' }

  before_create do
    last_number         = User.last.try(:id)
    self.account_number = format('%011d', last_number.nil? ? '1' : (last_number + 1).to_s)
  end

  def self.available_users(current_user_id)
    where.not(id: current_user_id).order(full_name: :asc).map do |user|
      ["#{user.username} - #{user.account_number}", user.id]
    end
  end
end
