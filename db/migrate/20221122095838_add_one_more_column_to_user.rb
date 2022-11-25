class AddOneMoreColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :activate, :boolean, default: false
    
  end
end
