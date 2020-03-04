class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :address
      t.string :category
      t.text :description
      t.float :latitude
      t.float :longitude
      t.date :start_date
      t.date :end_date
      t.integer :time_opening
      t.integer :time_closing
      t.timestamps
    end
  end
end
