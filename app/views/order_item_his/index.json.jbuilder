json.array!(@order_item_his) do |order_item_hi|
  json.extract! order_item_hi, :id, :BaseOrder_id, :Item_id, :BasePrice, :SalPrice, :Discount, :CreateTime, :BatchId, :GoDown_id, :Sum, :ExceUser, :ExceDate
  json.url order_item_hi_url(order_item_hi, format: :json)
end
