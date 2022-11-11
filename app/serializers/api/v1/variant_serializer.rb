class Api::V1::VariantSerializer < ActiveModel::Serializer
  # byebug
  attributes :id, :name, :variant_attributes

end