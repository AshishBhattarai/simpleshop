class AddIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :sku, unique: true
  end
end
