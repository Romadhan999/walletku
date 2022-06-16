module Transactions
  class RecalculateBalanceService
    def initialize(transaction_id:)
      @transaction = Transaction.find_by_id(transaction_id)
    end

    def call
      update_balance
    rescue ActiveRecord::RecordInvalid => e
      raise StandardError, e.record.errors.full_messages.to_sentence
    end

    private

    def update_balance
      case @transaction.action
      when 'sender'
        @transaction.sourceable.update_column(
          :balance, (@transaction.sourceable.balance - @transaction.transactable.amount)
        )
      when 'receiver'
        @transaction.sourceable.update_column(
          :balance, (@transaction.sourceable.balance + @transaction.transactable.amount)
        )
      end
    end
  end
end
