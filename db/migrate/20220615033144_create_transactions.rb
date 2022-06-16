class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :code
      t.string :transactable_type
      t.integer :transactable_id
      t.string :sourceable_type
      t.integer :sourceable_id
      t.string :action

      t.timestamps
    end
  end
end
