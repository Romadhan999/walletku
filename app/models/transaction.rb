class Transaction < ApplicationRecord
  extend Enumerize

  belongs_to :transactable, polymorphic: true
  belongs_to :sourceable, polymorphic: true

  enumerize :action, in: %i[sender receiver]

  after_create :recalculate_balance

  def recalculate_balance
    Transactions::RecalculateBalanceService.new(transaction_id: self.id).call
  end
end
