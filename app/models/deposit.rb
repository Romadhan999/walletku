class Deposit < ApplicationRecord
  include LogTransaction

  has_many :transactions, as: :transactable, dependent: :destroy

  belongs_to :sender, class_name: :Stock, foreign_key: :stock_id
  belongs_to :receiver, class_name: :User, foreign_key: :user_id

  validates :amount, :user_id, presence: true
  validates :amount, numericality: { greater_than: 19_999, message: 'minimum is Rp. 20.000' }
  validate  :available_card_balance

  def available_card_balance
    if stock_id.nil? || stock_id.blank?
      errors.add(:source_account, "can't be blank")
    elsif sender.balance < amount
      errors.add(:source_account, 'balance less than top up amount')
    end
  end
end
