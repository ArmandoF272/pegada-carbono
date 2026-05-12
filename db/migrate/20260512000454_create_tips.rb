class CreateTips < ActiveRecord::Migration[8.1]
  def change
    create_table :tips do |t|
      t.string :category
      t.text :text
      t.float :impact_tco2_year
      t.string :difficulty

      t.timestamps
    end
  end
end
