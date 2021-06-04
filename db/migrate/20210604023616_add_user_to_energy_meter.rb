class AddUserToEnergyMeter < ActiveRecord::Migration[6.1]
  def change
    add_reference :energy_meters, :user, null: false, foreign_key: true
  end
end
