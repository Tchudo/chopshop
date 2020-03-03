class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :name
      t.integer :stocks

      t.timestamps
    end
  end
end
