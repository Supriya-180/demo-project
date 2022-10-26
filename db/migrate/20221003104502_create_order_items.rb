class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.integer :product_quantity
      t.integer :total_price
      t.timestamps
    end
  end
end
