class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_sku
      t.string :brand
      t.text :description

      t.timestamps
    end
  end
end
