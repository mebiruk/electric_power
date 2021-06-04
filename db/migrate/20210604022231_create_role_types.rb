class CreateRoleTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :role_types do |t|
      t.string :role

      t.timestamps
    end
  end
end
