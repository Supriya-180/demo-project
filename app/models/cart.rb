class Cart < ApplicationRecord
	belongs_to :user
	validates_uniqueness_of :user_id

    has_many :cart_items, dependent: :destroy
    has_many :products, through: :cart_items
end
