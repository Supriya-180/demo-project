class VariantAttribute < ApplicationRecord
	belongs_to :variant
	validates :name, presence: true, uniqueness: { scope: :variant_id}

	before_create :safgd

	def safgd
		# byebug
		if self.present?
			
		end
	end
end
