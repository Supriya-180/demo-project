class RemoveColumnFromAddress < ActiveRecord::Migration[6.1]
  def change
    remove_column :addresses, :pin_Code
  end
end
