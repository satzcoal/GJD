json.array!(@item_out_orders) do |item_out_order|
  json.extract! item_out_order, :id, :id
  json.url item_out_order_url(item_out_order, format: :json)
end
