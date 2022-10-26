class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.belongs_to :product
      t.belongs_to :cart
      t.integer :product_quantity
      t.integer :total_price

      t.timestamps
    end
  end
end
