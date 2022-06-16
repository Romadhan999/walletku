class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :account_number
      t.string :name
      t.string :code
      t.decimal :balance, precision: 17, scale: 2, default: 0, null: false
      t.references :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
