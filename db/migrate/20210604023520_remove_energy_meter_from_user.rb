class RemoveEnergyMeterFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :energy_meter, null: false, foreign_key: true
  end
end
