class Product < ApplicationRecord
	belongs_to :category 
    belongs_to :user, optional: true
	validates :name, presence: true, uniqueness: { scope: :category_id }
    has_one_attached :image 
    has_many :cart_items, dependent: :destroy
    has_many :carts, :through => :cart_items
    has_many :product_variants, dependent: :destroy
    accepts_nested_attributes_for :product_variants, allow_destroy: true
    has_many :order_items, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy


    validates :name, presence: true 
    validates :image, presence: true 
    validates :price, presence: true
    validates :manufacturing_date, presence: true
    validates :price, numericality: { only_integer: true }

end
