class AddcolumnToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :razorpay_refund_id, :string
  end
end
