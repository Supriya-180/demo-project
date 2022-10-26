class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
