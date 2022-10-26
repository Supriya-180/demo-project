class AddDateToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :manufacturing_date, :datetime
  end
end
