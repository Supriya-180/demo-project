class ProductVariant < ApplicationRecord
	belongs_to :product
	belongs_to :variant
	belongs_to :variant_attribute
end
