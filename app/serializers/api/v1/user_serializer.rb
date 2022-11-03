class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :gender, :user_type, :phone_number
end
