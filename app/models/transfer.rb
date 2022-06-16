class Transfer < ApplicationRecord
  include LogTransaction

  has_many :transactions, as: :transactable, dependent: :destroy

  belongs_to :sender, class_name: :User, foreign_key: :sender_id
  belongs_to :receiver, class_name: :User, foreign_key: :receiver_id

  validates :amount, :sender_id, presence: true
  validates :amount, numericality: { greater_than: 9_999, message: 'minimum is Rp. 10.000' }
  validate  :available_wallet_balance

  def available_wallet_balance
    if receiver_id.nil? || receiver_id.blank?
      errors.add(:destination_account, "can't be blank")
    elsif sender.balance < amount
      errors.add(:wallet, 'balance less than transfer amount')
    end
  end
end
