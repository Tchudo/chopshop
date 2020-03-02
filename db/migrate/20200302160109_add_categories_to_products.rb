class AddCategoryToProducts < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :products, :categories, foreign_key: true
  end
end

