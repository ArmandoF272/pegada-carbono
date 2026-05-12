class CreateCalculations < ActiveRecord::Migration[8.1]
  def change
    create_table :calculations do |t|
      t.references :user, null: false, foreign_key: true
      t.date :reference_month
      t.float :total_emission
      t.boolean :saved

      t.timestamps
    end
  end
end
