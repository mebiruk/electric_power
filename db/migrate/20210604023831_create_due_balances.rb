class CreateDueBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :due_balances do |t|
      t.float :balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
