class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items, dependent: :destroy
	belongs_to :address

	enum status: [:created, :paymentcompleted, :cancelled, :refunded]

end
