class Variant < ApplicationRecord
	has_many :variant_attributes, dependent: :destroy
	accepts_nested_attributes_for :variant_attributes ,allow_destroy: true

	validates :name, presence: true, uniqueness: true
end
