class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.belongs_to :user 
      t.integer :pin_Code
      t.integer :flat_no
      t.string :colony     
      t.string :landmark
      t.string :city 
      t.timestamps
    end
  end
end
