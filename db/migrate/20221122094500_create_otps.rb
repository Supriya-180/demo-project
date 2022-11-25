class CreateOtps < ActiveRecord::Migration[6.1]
  def change
    create_table :otps do |t|
      t.integer :pin
      t.integer :phone_number
      t.boolean :activate, default: false
      t.timestamps
    end
  end
end
