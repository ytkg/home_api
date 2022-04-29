class CreateInstantaneousElectricPowers < ActiveRecord::Migration[7.0]
  def change
    create_table :instantaneous_electric_powers do |t|
      t.integer :value, null: false
      t.timestamps
    end
  end
end
