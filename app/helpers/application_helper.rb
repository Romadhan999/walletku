module ApplicationHelper
  def to_currency(value)
    return 'Rp. 0' if value.nil? || value.blank?

    ActionController::Base.helpers.number_to_currency(value, unit: 'Rp. ', delimiter: ',', separator: '.')
  end

  def to_datetime(value)
    l(value, format: '%d %B %Y, %H:%M %p') if value.present?
  end

  def wallet_badge_currency(transaction)
    case transaction.transactable_type
    when 'Deposit'
      "<div class='badge bg-success'>#{to_currency(transaction.transactable.amount)}</div>".html_safe
    when 'Withdraw'
      "<div class='badge bg-danger'>- #{to_currency(transaction.transactable.amount)}</div>".html_safe
    when 'Transfer'
      if transaction.action.sender?
        "<div class='badge bg-danger'>- #{to_currency(transaction.transactable.amount)}</div>".html_safe
      elsif transaction.action.receiver?
        "<div class='badge bg-success'>#{to_currency(transaction.transactable.amount)}</div>".html_safe
      end
    end
  end

  def card_badge_currency(transaction)
    case transaction.transactable_type
    when 'Deposit'
      "<div class='badge bg-danger'>- #{to_currency(transaction.transactable.amount)}</div>".html_safe
    when 'Withdraw'
      "<div class='badge bg-success'>#{to_currency(transaction.transactable.amount)}</div>".html_safe
    end
  end
end
