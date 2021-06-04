class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :region
      t.string :zone
      t.string :woreda
      t.string :kebele
      t.string :block_number
      t.string :house_number

      t.timestamps
    end
  end
end
