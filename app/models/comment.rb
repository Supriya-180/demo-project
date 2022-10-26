class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :product

	has_many :replies, class_name: "Comment",foreign_key: "reply_id"
	has_many :likes, as: :likeable, dependent: :destroy


    belongs_to :reply, class_name: "Comment", optional: true
    accepts_nested_attributes_for :replies, allow_destroy: true


    validates :description, presence: true 
end
