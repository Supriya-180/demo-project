class Api::V1::ProductSerializer < ActiveModel::Serializer
  # byebug
  attributes :id, :category_id, :name, :price
  attribute :image do |object|
    byebug
      Rails.application.routes.url_helpers.rails_blob_url(object.object.image) if object.object.image.attached?
  end

  attribute :like do |object|
    # current_user.likes.find_by(likeable_id: object.object.id, likeable_type: "Product")
    object.object.likes.find_by(user_id: current_user.id).present?
  end
end


# Like.where(likeable_id: 34).present?
