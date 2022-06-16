class CreateDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :deposits do |t|
      t.decimal :amount, precision: 17, scale: 2, default: 0, null: false
      t.references :user, foreign_key: { to_table: :users }
      t.references :stock, foreign_key: { to_table: :stocks }

      t.timestamps
    end
  end
end
