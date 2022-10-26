class CreateProductVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :product_variants do |t|
      t.belongs_to :product, index:true, foreign_key: true 
      t.belongs_to :variant, index:true, foreign_key: true
      t.belongs_to :variant_attribute, index:true, foreign_key: true
      t.timestamps
    end
  end
end
