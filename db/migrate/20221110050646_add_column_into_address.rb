class AddColumnIntoAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :pin_code, :bigint
  end
end
