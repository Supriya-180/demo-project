class CreateVariantAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :variant_attributes do |t|
      t.belongs_to :variant, index:true, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
