class Api::V1::OrderItemSerializer < ActiveModel::Serializer
  # byebug
  attributes :id, :order_id, :total_price, :product_quantity, :order

end
