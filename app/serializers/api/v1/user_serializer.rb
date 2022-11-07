class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :gender, :user_type, :phone_number

  # attribute :image do |object|

  #   Rails.application.routes.url_helpers.rails_blob_url(object.image) if object.image.attached?
  # end
end
