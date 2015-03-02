json.array!(@sale_orders) do |sale_order|
  json.extract! sale_order, :id, :id
  json.url sale_order_url(sale_order, format: :json)
end
