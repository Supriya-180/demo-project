class AddColumnIntoOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :Orders, :razorpay_order_id, :string 
    add_column :Orders, :razorpay_payment_id, :string 
  end
end
