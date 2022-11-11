class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :total_quantity, :order_items
end
