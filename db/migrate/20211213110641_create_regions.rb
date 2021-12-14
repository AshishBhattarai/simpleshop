class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :title
      t.string :country
      t.string :currency, limit: 3
      t.decimal :tax

      t.timestamps
    end
  end
end
