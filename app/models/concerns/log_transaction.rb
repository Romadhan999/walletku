module LogTransaction
  extend ActiveSupport::Concern

  included do
    before_create :create_log_transactions
  end

  def create_log_transactions
    transactions.build(code: generate_reference_code(self), action: :sender, sourceable: sender)
    transactions.build(code: generate_reference_code(self), action: :receiver, sourceable: receiver)
  end

  private

  def generate_reference_code(source)
    class_name  = source.class.name
    last_number = class_name.constantize.last.nil? ? 1 : class_name.constantize.last

    case class_name
    when 'Deposit' then format('DP%011d', last_number.id.to_s)
    when 'Withdraw' then format('WD%011d', last_number.id.to_s)
    when 'Transfer' then format('TF%011d', last_number.id.to_s)
    end
  end
end
