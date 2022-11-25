class CreateEmailOtps < ActiveRecord::Migration[6.1]
  def change
    create_table :email_otps do |t|
      t.integer :pin
      t.string :email
      t.boolean :activate, default: false
      t.datetime :valid_until
      t.timestamps
    end
  end
end
