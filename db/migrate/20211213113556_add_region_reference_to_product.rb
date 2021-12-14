class AddRegionReferenceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :regions, foreign_key: true, null: false
  end
end
