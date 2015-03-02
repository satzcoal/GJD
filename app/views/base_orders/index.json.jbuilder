json.array!(@base_orders) do |base_order|
  json.extract! base_order, :id, :OrderId, :type, :Total, :FactTotal, :From, :FromAddress, :From_Back, :From_BackAccountNum, :From_BackAccountName, :To, :ToAddress, :To_Back, :To_BackAccountNum, :To_BackAccountName, :MoneyState, :State, :CreateTime, :CreateUser
  json.url base_order_url(base_order, format: :json)
end
