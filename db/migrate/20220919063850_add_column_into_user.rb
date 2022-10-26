class AddColumnIntoUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string 
    add_column :users, :gender, :string
    add_column :users, :validity, :boolean  
  end

end
