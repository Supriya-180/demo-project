class Category < ApplicationRecord
	has_many :products, dependent: :destroy
	validates :name, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters..." }
	validates :name, presence: true
	validates_uniqueness_of :name
	accepts_nested_attributes_for :products
end
