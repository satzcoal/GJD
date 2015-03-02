json.array!(@billhis) do |billhi|
  json.extract! billhi, :id, :BaseOrder_id, :Total, :From, :FromAddress, :From_Back, :From_BackAccountNum, :From_BackAccountName, :To, :ToAddress, :To_Back, :To_BackAccountNum, :To_BackAccountName, :ExceTime, :ExceUser
  json.url billhi_url(billhi, format: :json)
end
