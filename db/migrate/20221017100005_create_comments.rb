class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :commenter_name
      t.text :description
      t.integer :user_id
      t.integer :product_id
      t.belongs_to :reply, foreign_key: { to_table: :comments }
      t.timestamps
    end
  end
end
