class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :phone_number
      t.string :email
      t.references :address, null: false, foreign_key: true
      t.date :connection_date
      t.references :role_type, null: false, foreign_key: true
      t.references :energy_meter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
