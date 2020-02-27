class RemoveTimeFromTimeTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :time_tables, :opened_at
    remove_column :time_tables, :closed_at
  end
end
