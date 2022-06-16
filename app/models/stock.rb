class Stock < ApplicationRecord
  belongs_to :user

  has_many :transactions, as: :sourceable

  validates :account_number, :code, :name, :balance, presence: true
  validates :account_number, :code, uniqueness: true

  scope :by_user, ->(user_id) { where(id: user_id) }

  before_create do
    self.balance = rand(250_000_000..1_000_000_000_000)
  end
end
