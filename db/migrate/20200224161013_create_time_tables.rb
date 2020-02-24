class CreateTimeTables < ActiveRecord::Migration[5.2]
  def change
    create_table :time_tables do |t|
      t.time :opened_at
      t.time :closed_at
      t.integer :day_of_week
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
