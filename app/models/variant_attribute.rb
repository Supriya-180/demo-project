class VariantAttribute < ApplicationRecord
	belongs_to :variant
	# validates_uniqueness_of :name
	validates :name, presence: true, uniqueness: { scope: :variant_id}

	before_create :safgd

	def safgd
		# byebug
		if self.present?
			
		end
	end
end
