class AddUserReferenceOnOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :users, foreign_key: true, null: false
  end
end
