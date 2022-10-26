class AddColumnToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :Orders, :address_id, :integer 
  end
end
