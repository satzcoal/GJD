json.array!(@order_items) do |order_item|
  json.extract! order_item, :id, :BaseOrder_id, :Item_id, :BasePrice, :SalPrice, :Discount, :CreateTime, :BatchId, :GoDown_id, :Sum
  json.url order_item_url(order_item, format: :json)
end
