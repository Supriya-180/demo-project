class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user 
      t.integer :total_price, default: 0
      t.integer :total_quantity, default: 0
      t.timestamps
    end
  end
end
