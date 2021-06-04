class CreateEnergyMeters < ActiveRecord::Migration[6.1]
  def change
    create_table :energy_meters do |t|
      t.float :power
      t.float :power_factor
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
