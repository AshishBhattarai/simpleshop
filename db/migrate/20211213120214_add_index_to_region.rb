class AddIndexToRegion < ActiveRecord::Migration[6.0]
  def change
    add_index :regions, :currency, unique: true
  end
end
