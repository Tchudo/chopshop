class AddTimeToTimeTables < ActiveRecord::Migration[5.2]
  def change
    add_column :time_tables, :opened_at, :integer
    add_column :time_tables, :closed_at, :integer
  end
end
