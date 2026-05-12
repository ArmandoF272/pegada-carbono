class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.references :calculation, null: false, foreign_key: true
      t.string :type
      t.float :emission_kg
      t.float :car_km
      t.float :bus_km
      t.float :flights_per_year
      t.float :kwh_consumption
      t.string :energy_source
      t.string :diet_type
      t.float :meat_kg
      t.float :monthly_spend
      t.string :shopping_category

      t.timestamps
    end
  end
end
