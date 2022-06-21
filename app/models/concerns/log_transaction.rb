module LogTransaction
  extend ActiveSupport::Concern

  included do
    before_create :create_log_transactions
  end

  def create_log_transactions
    reference_code = generate_reference_code(self)
    transactions.build(code: reference_code, action: :sender, sourceable: sender)
    transactions.build(code: reference_code, action: :receiver, sourceable: receiver)
  end

  private

  def generate_reference_code(source)
    class_name  = source.class.name
    last_number = class_name.constantize.last.nil? ? '1' : class_name.constantize.last.id.to_s

    case class_name
    when 'Deposit' then format('DP%011d', last_number)
    when 'Withdraw' then format('WD%011d', last_number)
    when 'Transfer' then format('TF%011d', last_number)
    end
  end
end
