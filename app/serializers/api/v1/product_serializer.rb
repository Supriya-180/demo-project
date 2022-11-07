class Api::V1::ProductSerializer < ActiveModel::Serializer
  # byebug
  attributes :id, :category_id, :name, :price
  attribute :image do |object|
    # byebug
      Rails.application.routes.url_helpers.rails_blob_url(object.object.image) if object.object.image.attached?
  end
end
