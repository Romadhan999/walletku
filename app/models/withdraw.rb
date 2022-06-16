class Withdraw < ApplicationRecord
  include LogTransaction

  has_many :transactions, as: :transactable, dependent: :destroy

  belongs_to :receiver, class_name: :Stock, foreign_key: :stock_id
  belongs_to :sender, class_name: :User, foreign_key: :user_id

  validates :amount, :user_id, presence: true
  validates :amount, numericality: { greater_than: 49_999, message: 'minimum is Rp. 50.000' }
  validate  :available_wallet_balance

  def available_wallet_balance
    if stock_id.nil? || stock_id.blank?
      errors.add(:destination_account, "can't be blank")
    elsif sender.balance < amount
      errors.add(:wallet, 'balance less than withdraw amount')
    end
  end
end
